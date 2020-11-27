Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E765F2C6C24
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 20:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbgK0TsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 14:48:15 -0500
Received: from mout.gmx.net ([212.227.17.20]:57173 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730084AbgK0Tpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606506084;
        bh=wu2nZP4IU+Top3OJoASjBBseXIv67/YM1/7RX5sWhD0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=jvX7XMEx7fnA1DeOff7TSpbnP6OqTJJOqVo4A7JtM4lpeALPWTWVDV0kATIHO35eu
         fsOaz/vrfl72PhphqyDLGGHDrIGdMX1zoiGMWCBAukHPzrJ0hFwPt3BpDYnotxuHoj
         F7CGg6LZcOaPKCKx9pKBUHVdKFVtXrWeFg/+ST64=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from pinea64lts.fritz.box ([62.143.246.89]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1N5GE1-1k1fCx3yCb-011BwR; Fri, 27 Nov 2020 20:20:59 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ivan Hu <ivan.hu@canonical.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin King <colin.king@canonical.com>,
        fwts-devel@lists.ubuntu.com,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi/efi_test: read RuntimeServicesSupported
Date:   Fri, 27 Nov 2020 20:20:51 +0100
Message-Id: <20201127192051.1430-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lWorqsxpAegYMv42EWAGou4VXMWq2jeLtSdLq2ZTmDI6syKzKM4
 JxPRHWZVYtXZcQAOl6Cvm0R7FduZ5lDyIVjtBGp/m/o9oJhKX2tOk8S8vkErwBDX7jkn2Ci
 vGzW4VbnKaQqOd0JTTI1kERCD/GYa6NEsWIBJWt0i/uT9r4N5lDX/Ju8R8VnK+0ZNBzmioM
 OXNdOQZnwGs8LhgcmkG1w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NzH4fWBJMG4=:Z+VSTbLmTHVlcLW+Mms6vY
 HU4y3gqHEGnmDF7jilRgKeIxowGf8hTzVQ+Nmwn5mBh00etGLwL76Njb2bTV/mDoRsWOX0Y8m
 4CImNrvw0FVqGK0K07XJ28h/kNbXuemxOIrfzncIgrHQRX/sW7wpYctCxCk/C8WmeGO25ofUV
 l+JipbPrjPuDN9Mle2Gz1C+E3mAMXjLtIHx7BrsH94mZ6p29KwIcmm7cPVRvR7MifIKBtI7j3
 5hH0CUXUn/eAHC1I20Rn767nyKi18k3Y7xzuMgmInTDcVJJvvuTw1CsIBAxnebSL1BFR3Q15P
 nyn65JbVAIJAtwkCquxFzcwmGuOOEID5p/lNrweMcfoSIs3iolIYj9GEo2JTby2+Qm8v7JSMk
 HnenlRP0zGygEcyh5fmIx42PVgMWRarIGX5C0RcG5s2OC/UCUl7sd8joRWhSKAxRpwiwUKspz
 1iEwI/FzEe2iJi+/u01lS+DMpId/yMBkWd4j2u/5nUWVBIfEkjtunRDFS93RETEL26vUW8fiU
 ixcW7pHw36XrfPzyr726khFh9dw34mv7f8qQkkDDkgEj348Q21mpjPgl/8bf85hClfGLQSIQR
 RTvQKYSVX4VmG8DxyxJskgign7npSQSuEyU5KPt0oqhE6ZuEr42WJDd8cVNJ64UXMxT4pRqEt
 vgNbfNMyhKThD2gNuFGLGy+mMcvSRF8pBFp2BJ5u/XiaOn543UGYdpExBrlwc+Dn56y/kUnT3
 GVTWq2EI7ZkcqknDHSX4+eJwQSDrgvD/sn3KRIHlCynFE47jIGn0kOo6mUt1FEepxxQHZhOEF
 aaSg3m1pWTgxd5HXn+UeSBlgK6J4V0tpzpZZhw4dfexLEnIKbNpavjR20RQ75lH+rdkecr4Ht
 Td6Q3ESvP+3H6YfLahmw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the UEFI 2.8A specification the UEFI enabled firmware provides a
configuration table EFI_RT_PROPERTIES_TABLE which indicates which runtime
services are enabled. The EFI stub reads this table and saves the value of
the field RuntimeServicesSupported internally.

The Firmware Test Suite requires the value to determine if UEFI runtime
services are correctly implemented.

With this patch an IOCTL call is provided to read the value of the field
RuntimeServicesSupported, e.g.

    #define EFI_RUNTIME_GET_SUPPORTED_MASK \
            _IOR('p', 0x0C, unsigned int)
    unsigned int mask;
    fd =3D open("/dev/efi_test", O_RDWR);
    ret =3D ioctl(fd, EFI_RUNTIME_GET_SUPPORTED_MASK, &mask);

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 drivers/firmware/efi/test/efi_test.c | 16 ++++++++++++++++
 drivers/firmware/efi/test/efi_test.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/t=
est/efi_test.c
index ddf9eae396fe..47d67bb0a516 100644
=2D-- a/drivers/firmware/efi/test/efi_test.c
+++ b/drivers/firmware/efi/test/efi_test.c
@@ -663,6 +663,19 @@ static long efi_runtime_query_capsulecaps(unsigned lo=
ng arg)
 	return rv;
 }

+static long efi_runtime_get_supported_mask(unsigned long arg)
+{
+	unsigned int __user *supported_mask;
+	int rv =3D 0;
+
+	supported_mask =3D (unsigned int *)arg;
+
+	if (put_user(efi.runtime_supported_mask, supported_mask))
+		rv =3D -EFAULT;
+
+	return rv;
+}
+
 static long efi_test_ioctl(struct file *file, unsigned int cmd,
 							unsigned long arg)
 {
@@ -699,6 +712,9 @@ static long efi_test_ioctl(struct file *file, unsigned=
 int cmd,

 	case EFI_RUNTIME_RESET_SYSTEM:
 		return efi_runtime_reset_system(arg);
+
+	case EFI_RUNTIME_GET_SUPPORTED_MASK:
+		return efi_runtime_get_supported_mask(arg);
 	}

 	return -ENOTTY;
diff --git a/drivers/firmware/efi/test/efi_test.h b/drivers/firmware/efi/t=
est/efi_test.h
index f2446aa1c2e3..117349e57993 100644
=2D-- a/drivers/firmware/efi/test/efi_test.h
+++ b/drivers/firmware/efi/test/efi_test.h
@@ -118,4 +118,7 @@ struct efi_resetsystem {
 #define EFI_RUNTIME_RESET_SYSTEM \
 	_IOW('p', 0x0B, struct efi_resetsystem)

+#define EFI_RUNTIME_GET_SUPPORTED_MASK \
+	_IOR('p', 0x0C, unsigned int)
+
 #endif /* _DRIVERS_FIRMWARE_EFI_TEST_H_ */
=2D-
2.29.2

