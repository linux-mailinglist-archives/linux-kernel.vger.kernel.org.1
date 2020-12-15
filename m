Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42092DAB94
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 12:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgLOLCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 06:02:48 -0500
Received: from mx.exactcode.de ([144.76.154.42]:54020 "EHLO mx.exactcode.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727637AbgLOLC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 06:02:29 -0500
X-Greylist: delayed 1399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Dec 2020 06:02:27 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de; s=x;
        h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:CC:To:Message-Id:Date; bh=bLm9vOu3TwJGdECbw3Ojkbv+Hq3sYGX+hyAq18pYH8U=;
        b=o3O6FyiyvPNosJooOhAClIGmf79wURA5ZqrbX/fZwoboHDXjhYEIt31RATtWTLdfVgrE91/HhrdZ3nlKm59U/LlwOfSYM5ypUTFJThvgq6LpHesKUXQl0W0XVQJWzBrLOprGQBGCeqQSpkBMWUemuLH5VOC8BeC56uiqZj/GJ3g=;
Received: from exactco.de ([90.187.5.221])
        by mx.exactcode.de with esmtp (Exim 4.82)
        (envelope-from <rene@exactcode.com>)
        id 1kp7jR-0004OQ-JZ; Tue, 15 Dec 2020 10:39:01 +0000
Received: from [192.168.2.130] (helo=localhost)
        by exactco.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.86_2)
        (envelope-from <rene@exactcode.com>)
        id 1kp7Y6-0001YT-VD; Tue, 15 Dec 2020 10:27:19 +0000
Date:   Tue, 15 Dec 2020 11:38:40 +0100 (CET)
Message-Id: <20201215.113840.1449591537716736303.rene@exactcode.com>
To:     linux-kernel@vger.kernel.org
CC:     Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3] zstd compressed firmware loading
From:   Rene Rebe <rene@exactcode.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.2 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now with zstd compressed kernel & initrd upstream, we would rather
compress everything with one type of compressor, so I added support
for zstd compressed firmware loading, too. Renamed FW_LOADER_COMPRESS
to FW_LOADER_COMPRESS_XZ to indicate algorithm used.

Tested on x86_64, sparc64 and mips64.

Signed-off-by: Ren=E9 Rebe <rene@exactcode.de>

diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmwa=
re_loader/Kconfig
index 5b24f3959255..92e6bec4605a 100644
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -155,8 +155,8 @@ config FW_LOADER_USER_HELPER_FALLBACK
 =

 	  If you are unsure about this, say N here.
 =

-config FW_LOADER_COMPRESS
-	bool "Enable compressed firmware support"
+config FW_LOADER_COMPRESS_XZ
+	bool "Enable XZ compressed firmware support"
 	select FW_LOADER_PAGED_BUF
 	select XZ_DEC
 	help
@@ -169,6 +169,16 @@ config FW_LOADER_COMPRESS
 	  be compressed with either none or crc32 integrity check type (pass
 	  "-C crc32" option to xz command).
 =

+config FW_LOADER_COMPRESS_ZSTD
+	bool "Enable Zstd compressed firmware support"
+	select FW_LOADER_PAGED_BUF
+	select ZSTD_DECOMPRESS
+	help
+	  This option enables the support for loading Zstd compressed firmwar=
e
+	  files. The caller of firmware API receives the decompressed file
+	  content. The compressed file is loaded as a fallback, only after
+	  loading the raw file failed at first.
+
 config FW_CACHE
 	bool "Enable firmware caching during suspend"
 	depends on PM_SLEEP
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmwar=
e_loader/main.c
index 78355095e00d..0b1ea5e0708d 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -34,7 +34,9 @@
 #include <linux/syscore_ops.h>
 #include <linux/reboot.h>
 #include <linux/security.h>
+#include <linux/decompress/mm.h>
 #include <linux/xz.h>
+#include <linux/zstd.h>
 =

 #include <generated/utsrelease.h>
 =

@@ -365,7 +367,7 @@ int fw_map_paged_buf(struct fw_priv *fw_priv)
 /*
  * XZ-compressed firmware support
  */
-#ifdef CONFIG_FW_LOADER_COMPRESS
+#ifdef CONFIG_FW_LOADER_COMPRESS_XZ
 /* show an error and return the standard error code */
 static int fw_decompress_xz_error(struct device *dev, enum xz_ret xz_r=
et)
 {
@@ -459,7 +461,186 @@ static int fw_decompress_xz(struct device *dev, s=
truct fw_priv *fw_priv,
 	else
 		return fw_decompress_xz_pages(dev, fw_priv, in_size, in_buffer);
 }
-#endif /* CONFIG_FW_LOADER_COMPRESS */
+#endif /* CONFIG_FW_LOADER_COMPRESS_XZ */
+
+/*
+ * Zstd-compressed firmware support
+ */
+#ifdef CONFIG_FW_LOADER_COMPRESS_ZSTD
+/* show an error and return the standard error code */
+static int handle_zstd_error(size_t ret)
+{
+	const int err =3D ZSTD_getErrorCode(ret);
+
+	if (!ZSTD_isError(ret))
+		return 0;
+
+	switch (err) {
+	case ZSTD_error_memory_allocation:
+		printk("ZSTD decompressor ran out of memory");
+		break;
+	case ZSTD_error_prefix_unknown:
+		printk("Input is not in the ZSTD format (wrong magic bytes)");
+		break;
+	case ZSTD_error_dstSize_tooSmall:
+	case ZSTD_error_corruption_detected:
+	case ZSTD_error_checksum_wrong:
+		printk("ZSTD-compressed data is corrupt");
+		break;
+	default:
+		printk("ZSTD-compressed data is probably corrupt");
+		break;
+	}
+	return -1;
+}
+
+/* single-shot decompression onto the pre-allocated buffer */
+static int fw_decompress_zstd_single(struct device *dev, struct fw_pri=
v *fw_priv,
+				   size_t in_size, const void *in_buffer)
+{
+	const size_t wksp_size =3D ZSTD_DCtxWorkspaceBound();
+	void *wksp =3D large_malloc(wksp_size);
+	ZSTD_DCtx *dctx =3D ZSTD_initDCtx(wksp, wksp_size);
+	int err;
+	size_t ret;
+
+	if (dctx =3D=3D NULL) {
+	        dev_warn(dev, "Out of memory while allocating ZSTD_DCtx");
+		err =3D -1;
+		goto out;
+	}
+	/* Find out how large the frame actually is, there may be junk at
+	 * the end of the frame that ZSTD_decompressDCtx() can't handle.
+	 */
+	ret =3D ZSTD_findFrameCompressedSize(in_buffer, in_size);
+	err =3D handle_zstd_error(ret);
+	if (err)
+		goto out;
+	in_size =3D (long)ret;
+
+	ret =3D ZSTD_decompressDCtx(dctx, fw_priv->data, fw_priv->allocated_s=
ize, in_buffer, in_size);
+	err =3D handle_zstd_error(ret);
+	if (err)
+		goto out;
+
+	fw_priv->size =3D ret;
+
+out:
+	if (wksp !=3D NULL)
+		large_free(wksp);
+	return err;
+}
+
+/* decompression on paged buffer and map it */
+static int fw_decompress_zstd_pages(struct device *dev, struct fw_priv=
 *fw_priv,
+				  size_t in_size, const void *in_buffer)
+{
+	ZSTD_inBuffer in;
+	ZSTD_outBuffer out;
+	ZSTD_frameParams params;
+	void *wksp =3D NULL;
+	size_t wksp_size;
+	ZSTD_DStream *dstream;
+	int err =3D 0;
+	size_t ret;
+
+	struct page *page;
+
+	fw_priv->is_paged_buf =3D true;
+	fw_priv->size =3D 0;
+
+	/* Set the first non-empty input buffer. */
+	in.src =3D in_buffer;
+	in.pos =3D 0;
+	in.size =3D in_size;
+
+	/*
+	 * We need to know the window size to allocate the ZSTD_DStream.
+	 * Since we are streaming, we need to allocate a buffer for the slidi=
ng
+	 * window. The window size varies from 1 KB to ZSTD_WINDOWSIZE_MAX
+	 * (8 MB), so it is important to use the actual value so as not to
+	 * waste memory when it is smaller.
+	 */
+	ret =3D ZSTD_getFrameParams(&params, in.src, in.size);
+	err =3D handle_zstd_error(ret);
+	if (err)
+		goto out;
+	if (ret !=3D 0) {
+		printk("ZSTD-compressed data has an incomplete frame header");
+		err =3D -1;
+		goto out;
+	}
+	if (params.windowSize > (1 << ZSTD_WINDOWLOG_MAX)) {
+		printk("ZSTD-compressed data has too large a window size");
+		err =3D -1;
+		goto out;
+	}
+
+	/*
+	 * Allocate the ZSTD_DStream now that we know how much memory is
+	 * required.
+	 */
+	wksp_size =3D ZSTD_DStreamWorkspaceBound(params.windowSize);
+	wksp =3D large_malloc(wksp_size);
+	dstream =3D ZSTD_initDStream(params.windowSize, wksp, wksp_size);
+	if (dstream =3D=3D NULL) {
+		printk("Out of memory while allocating ZSTD_DStream");
+		err =3D -1;
+		goto out;
+	}
+
+	/*
+	 * Decompression loop:
+	 * Read more data if necessary (error if no more data can be read).
+	 * Call the decompression function, which returns 0 when finished.
+	 * Flush any data produced if using flush().
+	 */
+	do {
+		/* If we need to reload data the input is truncated. */
+		if (in.pos =3D=3D in.size) {
+			printk("ZSTD-compressed data is truncated");
+			err =3D -1;
+			goto out;
+		}
+
+		/* Allocate the output buffer */
+		if (fw_grow_paged_buf(fw_priv, fw_priv->nr_pages + 1)) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+
+		/* Decompress into the newly allocated page */
+		page =3D fw_priv->pages[fw_priv->nr_pages - 1];
+		out.dst =3D kmap(page);
+		out.pos =3D 0;
+		out.size =3D PAGE_SIZE;
+
+		/* Returns zero when the frame is complete. */
+		ret =3D ZSTD_decompressStream(dstream, &out, &in);
+		kunmap(page);
+		err =3D handle_zstd_error(ret);
+		if (err)
+			goto out;
+		fw_priv->size +=3D out.pos;
+	} while (ret !=3D 0);
+
+	err =3D fw_map_paged_buf(fw_priv);
+out:
+	if (wksp !=3D NULL)
+		large_free(wksp);
+	return err;
+}
+
+static int fw_decompress_zstd(struct device *dev, struct fw_priv *fw_p=
riv,
+			    size_t in_size, const void *in_buffer)
+{
+	/* if the buffer is pre-allocated, we can perform in single-shot mode=
 */
+	if (fw_priv->data)
+		return fw_decompress_zstd_single(dev, fw_priv, in_size, in_buffer);
+	else
+		return fw_decompress_zstd_pages(dev, fw_priv, in_size, in_buffer);
+}
+#endif /* CONFIG_FW_LOADER_COMPRESS_ZSTD */
 =

 /* direct firmware loading support */
 static char fw_path_para[256];
@@ -814,10 +995,15 @@ _request_firmware(const struct firmware **firmwar=
e_p, const char *name,
 	if (!(opt_flags & FW_OPT_PARTIAL))
 		nondirect =3D true;
 =

-#ifdef CONFIG_FW_LOADER_COMPRESS
+#ifdef CONFIG_FW_LOADER_COMPRESS_XZ
 	if (ret =3D=3D -ENOENT && nondirect)
 		ret =3D fw_get_filesystem_firmware(device, fw->priv, ".xz",
 						 fw_decompress_xz);
+#endif
+#ifdef CONFIG_FW_LOADER_COMPRESS_ZSTD
+	if (ret =3D=3D -ENOENT && nondirect)
+		ret =3D fw_get_filesystem_firmware(device, fw->priv, ".zst",
+						 fw_decompress_zstd);
 #endif
 	if (ret =3D=3D -ENOENT && nondirect)
 		ret =3D firmware_fallback_platform(fw->priv);
diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing=
/selftests/firmware/fw_lib.sh
index 5b8c0fedee76..0eafd6bd0aba 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -62,7 +62,7 @@ check_setup()
 {
 	HAS_FW_LOADER_USER_HELPER=3D"$(kconfig_has CONFIG_FW_LOADER_USER_HELP=
ER=3Dy)"
 	HAS_FW_LOADER_USER_HELPER_FALLBACK=3D"$(kconfig_has CONFIG_FW_LOADER_=
USER_HELPER_FALLBACK=3Dy)"
-	HAS_FW_LOADER_COMPRESS=3D"$(kconfig_has CONFIG_FW_LOADER_COMPRESS=3Dy=
)"
+	HAS_FW_LOADER_COMPRESS_XZ=3D"$(kconfig_has CONFIG_FW_LOADER_COMPRESS_=
XZ=3Dy)"
 	PROC_FW_IGNORE_SYSFS_FALLBACK=3D"0"
 	PROC_FW_FORCE_SYSFS_FALLBACK=3D"0"
 =

@@ -98,9 +98,9 @@ check_setup()
 =

 	OLD_FWPATH=3D"$(cat /sys/module/firmware_class/parameters/path)"
 =

-	if [ "$HAS_FW_LOADER_COMPRESS" =3D "yes" ]; then
+	if [ "$HAS_FW_LOADER_COMPRESS_XZ" =3D "yes" ]; then
 		if ! which xz 2> /dev/null > /dev/null; then
-			HAS_FW_LOADER_COMPRESS=3D""
+			HAS_FW_LOADER_COMPRESS_XZ=3D""
 		fi
 	fi
 }

-- =

  Ren=E9 Rebe, ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
  https://exactcode.com | https://t2sde.org | https://rene.rebe.de
