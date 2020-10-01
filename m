Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE672805CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732935AbgJARsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJARsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:48:12 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F95FC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:48:12 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h23so2273132pjv.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=vF3W98bYzsN3dL/a8/qGBHGO8duae7jFkKkWIk+KpVE=;
        b=QtehLMsYXytX2OH2l90nCUSYqKSJJotCKHembsfShdp4CETzEKUrKRHpzTIkx9fR4r
         tH1vni/y6xIz15a4JrUCmJgD31sG9I5nX3ah2rTyT3IsEahGN5LgCozBsNntALQ1Wrah
         FJa7GFe8It3TiZ2pKZTzVkgqC4pUAGiR907mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=vF3W98bYzsN3dL/a8/qGBHGO8duae7jFkKkWIk+KpVE=;
        b=fdTrMA34i70Kjtzccnvs9l0fDrDKMWITZnwk4Cx4bZfUkAzetGaqn3e7wPqsKX/LCL
         BiipjItiTFe3yxc6L5mJEV3gs9temdd+94vI8UPv2qUS4U8utb9RAWmVzLLKUzGPsGVt
         UNJrZjgFulO1OglQkmhMC6JcCmaC1I43hVkAtfNQxsuf2jl+6J9ZNWXa7/BOZRhn5mdr
         KfYvGva00V0PatO/GGuvVIUyWjYy1pWdIQ8N6giiFRrAANIz1a3wethQhs9FigyXosDP
         HD+UJfKSPBTote0FXgO8RUIdSzC2p+M3GeSUc0EPIb+JjHqvZ+tKTsZ5TdxgEAqCEENI
         IZGQ==
X-Gm-Message-State: AOAM532S2W8625m3jW5X9F80y69rUHl/p8a7NtWMB6yKG1b3opKcLT5U
        Fxk0Tm9S1z+nobRp1jLE+3IJKQ==
X-Google-Smtp-Source: ABdhPJxnTSX6boEQbdp8pFd6W08XXHDwgOQxMNDiNa6aGeiKc1rlO3oYvxQQ9QY+fYTtnX6cGyLlEA==
X-Received: by 2002:a17:90a:ee97:: with SMTP id i23mr988805pjz.161.1601574491838;
        Thu, 01 Oct 2020 10:48:11 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v65sm5536287pgv.21.2020.10.01.10.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 10:48:10 -0700 (PDT)
Subject: Re: [PATCH v5 03/15] misc: bcm-vk: add autoload support
To:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
References: <20201001012810.4172-4-scott.branden@broadcom.com>
 <202010011123.tZnlIwLB-lkp@intel.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <1478f8a3-4470-3529-90a0-c6a04703e76a@broadcom.com>
Date:   Thu, 1 Oct 2020 10:48:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202010011123.tZnlIwLB-lkp@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b32fc705b09f9ec3"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b32fc705b09f9ec3
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-CA



On 2020-09-30 9:07 p.m., kernel test robot wrote:
> Hi Scott,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on char-misc/char-misc-testing]
> [also build test ERROR on soc/for-next kees/for-next/pstore linus/master v5.9-rc7 next-20200930]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
Yes, this patch series will not compile as described in the cover letter without Kees' patches:

This patch series drops previous patches in [1]
that were incorporated by Kees Cook into patch series
"Introduce partial kernel_read_file() support" [2].

Remaining patches are contained in this series to add Broadcom VK driver.
(which depends on request_firmware_into_buf API addition in
other patch series [2] being applied first).

Please note this patch series will not compile without [2].

[1] https://lore.kernel.org/lkml/20200706232309.12010-1-scott.branden@broadcom.com/
[2] https://lore.kernel.org/lkml/20200729175845.1745471-1-keescook@chromium.org/



> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Scott-Branden/Add-Broadcom-VK-driver/20201001-093119
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git c471bf4b11c7df0f0f9f42b5aeec424dc62d0c7e
> config: powerpc-allyesconfig (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/f04a1673933a1af94e44bc650533bbb271e3dcc1
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Scott-Branden/Add-Broadcom-VK-driver/20201001-093119
>         git checkout f04a1673933a1af94e44bc650533bbb271e3dcc1
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/misc/bcm-vk/bcm_vk_dev.c: In function 'bcm_vk_load_image_by_type':
>>> drivers/misc/bcm-vk/bcm_vk_dev.c:284:8: error: implicit declaration of function 'request_partial_firmware_into_buf'; did you mean 'request_firmware_into_buf'? [-Werror=implicit-function-declaration]
>      284 |  ret = request_partial_firmware_into_buf(&fw, filename, dev,
>          |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |        request_firmware_into_buf
>    cc1: some warnings being treated as errors
>
> vim +284 drivers/misc/bcm-vk/bcm_vk_dev.c
>
>    206	
>    207	static int bcm_vk_load_image_by_type(struct bcm_vk *vk, u32 load_type,
>    208					     const char *filename)
>    209	{
>    210		struct device *dev = &vk->pdev->dev;
>    211		const struct firmware *fw = NULL;
>    212		void *bufp = NULL;
>    213		size_t max_buf, offset;
>    214		int ret;
>    215		u64 offset_codepush;
>    216		u32 codepush;
>    217		u32 value;
>    218		dma_addr_t boot_dma_addr;
>    219		bool is_stdalone;
>    220	
>    221		if (load_type == VK_IMAGE_TYPE_BOOT1) {
>    222			/*
>    223			 * After POR, enable VK soft BOOTSRC so bootrom do not clear
>    224			 * the pushed image (the TCM memories).
>    225			 */
>    226			value = vkread32(vk, BAR_0, BAR_BOOTSRC_SELECT);
>    227			value |= BOOTSRC_SOFT_ENABLE;
>    228			vkwrite32(vk, value, BAR_0, BAR_BOOTSRC_SELECT);
>    229	
>    230			codepush = CODEPUSH_BOOTSTART + CODEPUSH_BOOT1_ENTRY;
>    231			offset_codepush = BAR_CODEPUSH_SBL;
>    232	
>    233			/* Write a 1 to request SRAM open bit */
>    234			vkwrite32(vk, CODEPUSH_BOOTSTART, BAR_0, offset_codepush);
>    235	
>    236			/* Wait for VK to respond */
>    237			ret = bcm_vk_wait(vk, BAR_0, BAR_BOOT_STATUS, SRAM_OPEN,
>    238					  SRAM_OPEN, LOAD_IMAGE_TIMEOUT_MS);
>    239			if (ret < 0) {
>    240				dev_err(dev, "boot1 wait SRAM err - ret(%d)\n", ret);
>    241				goto err_buf_out;
>    242			}
>    243	
>    244			max_buf = SZ_256K;
>    245			bufp = dma_alloc_coherent(dev,
>    246						  max_buf,
>    247						  &boot_dma_addr, GFP_KERNEL);
>    248			if (!bufp) {
>    249				dev_err(dev, "Error allocating 0x%zx\n", max_buf);
>    250				ret = -ENOMEM;
>    251				goto err_buf_out;
>    252			}
>    253		} else if (load_type == VK_IMAGE_TYPE_BOOT2) {
>    254			codepush = CODEPUSH_BOOT2_ENTRY;
>    255			offset_codepush = BAR_CODEPUSH_SBI;
>    256	
>    257			/* Wait for VK to respond */
>    258			ret = bcm_vk_wait(vk, BAR_0, BAR_BOOT_STATUS, DDR_OPEN,
>    259					  DDR_OPEN, LOAD_IMAGE_TIMEOUT_MS);
>    260			if (ret < 0) {
>    261				dev_err(dev, "boot2 wait DDR open error - ret(%d)\n",
>    262					ret);
>    263				goto err_buf_out;
>    264			}
>    265	
>    266			max_buf = SZ_4M;
>    267			bufp = dma_alloc_coherent(dev,
>    268						  max_buf,
>    269						  &boot_dma_addr, GFP_KERNEL);
>    270			if (!bufp) {
>    271				dev_err(dev, "Error allocating 0x%zx\n", max_buf);
>    272				ret = -ENOMEM;
>    273				goto err_buf_out;
>    274			}
>    275	
>    276			bcm_vk_buf_notify(vk, bufp, boot_dma_addr, max_buf);
>    277		} else {
>    278			dev_err(dev, "Error invalid image type 0x%x\n", load_type);
>    279			ret = -EINVAL;
>    280			goto err_buf_out;
>    281		}
>    282	
>    283		offset = 0;
>  > 284		ret = request_partial_firmware_into_buf(&fw, filename, dev,
>    285							bufp, max_buf, offset);
>    286		if (ret) {
>    287			dev_err(dev, "Error %d requesting firmware file: %s\n",
>    288				ret, filename);
>    289			goto err_firmware_out;
>    290		}
>    291		dev_dbg(dev, "size=0x%zx\n", fw->size);
>    292		if (load_type == VK_IMAGE_TYPE_BOOT1)
>    293			memcpy_toio(vk->bar[BAR_1] + BAR1_CODEPUSH_BASE_BOOT1,
>    294				    bufp,
>    295				    fw->size);
>    296	
>    297		dev_dbg(dev, "Signaling 0x%x to 0x%llx\n", codepush, offset_codepush);
>    298		vkwrite32(vk, codepush, BAR_0, offset_codepush);
>    299	
>    300		if (load_type == VK_IMAGE_TYPE_BOOT1) {
>    301			u32 boot_status;
>    302	
>    303			/* wait until done */
>    304			ret = bcm_vk_wait(vk, BAR_0, BAR_BOOT_STATUS,
>    305					  BOOT1_RUNNING,
>    306					  BOOT1_RUNNING,
>    307					  BOOT1_STARTUP_TIMEOUT_MS);
>    308	
>    309			boot_status = vkread32(vk, BAR_0, BAR_BOOT_STATUS);
>    310			is_stdalone = !BCM_VK_INTF_IS_DOWN(boot_status) &&
>    311				      (boot_status & BOOT_STDALONE_RUNNING);
>    312			if (ret && !is_stdalone) {
>    313				dev_err(dev,
>    314					"Timeout %ld ms waiting for boot1 to come up - ret(%d)\n",
>    315					BOOT1_STARTUP_TIMEOUT_MS, ret);
>    316				goto err_firmware_out;
>    317			} else if (is_stdalone) {
>    318				u32 reg;
>    319	
>    320				reg = vkread32(vk, BAR_0, BAR_BOOT1_STDALONE_PROGRESS);
>    321				if ((reg & BOOT1_STDALONE_PROGRESS_MASK) ==
>    322					     BOOT1_STDALONE_SUCCESS) {
>    323					dev_info(dev, "Boot1 standalone success\n");
>    324					ret = 0;
>    325				} else {
>    326					dev_err(dev, "Timeout %ld ms - Boot1 standalone failure\n",
>    327						BOOT1_STARTUP_TIMEOUT_MS);
>    328					ret = -EINVAL;
>    329					goto err_firmware_out;
>    330				}
>    331			}
>    332		} else if (load_type == VK_IMAGE_TYPE_BOOT2) {
>    333			unsigned long timeout;
>    334	
>    335			timeout = jiffies + msecs_to_jiffies(LOAD_IMAGE_TIMEOUT_MS);
>    336	
>    337			/* To send more data to VK than max_buf allowed at a time */
>    338			do {
>    339				/*
>    340				 * Check for ack from card. when Ack is received,
>    341				 * it means all the data is received by card.
>    342				 * Exit the loop after ack is received.
>    343				 */
>    344				ret = bcm_vk_wait(vk, BAR_0, BAR_BOOT_STATUS,
>    345						  FW_LOADER_ACK_RCVD_ALL_DATA,
>    346						  FW_LOADER_ACK_RCVD_ALL_DATA,
>    347						  TXFR_COMPLETE_TIMEOUT_MS);
>    348				if (ret == 0) {
>    349					dev_dbg(dev, "Exit boot2 download\n");
>    350					break;
>    351				} else if (ret == -EFAULT) {
>    352					dev_err(dev, "Error detected during ACK waiting");
>    353					goto err_firmware_out;
>    354				}
>    355	
>    356				/* exit the loop, if there is no response from card */
>    357				if (time_after(jiffies, timeout)) {
>    358					dev_err(dev, "Error. No reply from card\n");
>    359					ret = -ETIMEDOUT;
>    360					goto err_firmware_out;
>    361				}
>    362	
>    363				/* Wait for VK to open BAR space to copy new data */
>    364				ret = bcm_vk_wait(vk, BAR_0, offset_codepush,
>    365						  codepush, 0,
>    366						  TXFR_COMPLETE_TIMEOUT_MS);
>    367				if (ret == 0) {
>    368					offset += max_buf;
>    369					ret = request_partial_firmware_into_buf
>    370							(&fw,
>    371							 filename,
>    372							 dev, bufp,
>    373							 max_buf,
>    374							 offset);
>    375					if (ret) {
>    376						dev_err(dev,
>    377							"Error %d requesting firmware file: %s offset: 0x%zx\n",
>    378							ret, filename, offset);
>    379						goto err_firmware_out;
>    380					}
>    381					dev_dbg(dev, "size=0x%zx\n", fw->size);
>    382					dev_dbg(dev, "Signaling 0x%x to 0x%llx\n",
>    383						codepush, offset_codepush);
>    384					vkwrite32(vk, codepush, BAR_0, offset_codepush);
>    385					/* reload timeout after every codepush */
>    386					timeout = jiffies +
>    387					    msecs_to_jiffies(LOAD_IMAGE_TIMEOUT_MS);
>    388				} else if (ret == -EFAULT) {
>    389					dev_err(dev, "Error detected waiting for transfer\n");
>    390					goto err_firmware_out;
>    391				}
>    392			} while (1);
>    393	
>    394			/* wait for fw status bits to indicate app ready */
>    395			ret = bcm_vk_wait(vk, BAR_0, VK_BAR_FWSTS,
>    396					  VK_FWSTS_READY,
>    397					  VK_FWSTS_READY,
>    398					  BOOT2_STARTUP_TIMEOUT_MS);
>    399			if (ret < 0) {
>    400				dev_err(dev, "Boot2 not ready - ret(%d)\n", ret);
>    401				goto err_firmware_out;
>    402			}
>    403	
>    404			is_stdalone = vkread32(vk, BAR_0, BAR_BOOT_STATUS) &
>    405				      BOOT_STDALONE_RUNNING;
>    406			if (!is_stdalone) {
>    407				ret = bcm_vk_intf_ver_chk(vk);
>    408				if (ret) {
>    409					dev_err(dev, "failure in intf version check\n");
>    410					goto err_firmware_out;
>    411				}
>    412	
>    413				/* sync & channel other info */
>    414				ret = bcm_vk_sync_card_info(vk);
>    415				if (ret) {
>    416					dev_err(dev, "Syncing Card Info failure\n");
>    417					goto err_firmware_out;
>    418				}
>    419			}
>    420		}
>    421	
>    422	err_firmware_out:
>    423		release_firmware(fw);
>    424	
>    425	err_buf_out:
>    426		if (bufp)
>    427			dma_free_coherent(dev, max_buf, bufp, boot_dma_addr);
>    428	
>    429		return ret;
>    430	}
>    431	
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


--000000000000b32fc705b09f9ec3
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
I/3RRboOeC9M13VNr5feU91O0iDoMreAgPQJ0Lo7YrodKYug0Tt/fFDjkW3v3VIbEr2liUN69U0C
AwEAAaOCAdEwggHNMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYIKwYBBQUH
MAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxzaWduMnNo
YTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vZ3Nw
ZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEQGA1Ud
HwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNpZ24yc2hh
MmczLmNybDAlBgNVHREEHjAcgRpzY290dC5icmFuZGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQUWOK7
qiyDSt/IDm/SRcNi/sTEiyswDQYJKoZIhvcNAQELBQADggEBAEe2edd4F9tpp0GPmrFrQ+xp9kY7
uxBzPdCw588bgVrPemjLwiwV37XTT4iWJtNhPfEpaguM6jeLm58LCvHq5/IBjcyHyf4URQVwAg7B
pqkH8/M+IBstu4/D+znPHB59X+c+au3Q8D+xoNFd7I30kaE+oJuBuFsGXRBc0Ci+FM86x9k7SF8U
aui1E7Y9wDfsRSCL2TSwU773f09WkrvVdlKxNqQZj2z7bQUUn+yfXdFfBz0LqlYNfn7xJOpQE3HI
H4jq6U9+b0Qf+J0n0wyysjXPSeQ7EKXVkT8dM2KSpIN86v5dd9LkAz3C1dmjuPRGEC8ZhI1IjMBt
0itrn6C23NsxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0g
RzMCDFtD165RQeUC8DvoCDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgFU9XnfnR
0rgd4+RiFYtvPpx7U6IGlDcv9i23jUM5LP4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMjAxMDAxMTc0ODEyWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAJlUEe1A24ZMCh/VdyV4q5pTUYbj
mP4scUc1uy8H3iq6MA5N40LP0sgd2vhmzvsThj0yxjcuF0w33KXRVR7gxCWR/sTgWEAdvSbs2wUC
So/LS19eBD7g9rEW2JtUnyj5pljgj7zVmw7LK2AvIIO4gOx522gc052PmiRGT15PslVS9yC2cIpf
CK/URWjfYZxfS7C1XbJIuXr0ElH0cQdZCpQzLczV/moC3V4aPB8ZCcyHYcn/S3wVyUh4+lrJYveS
C9zMpTyjBKE3R7DUVOPmqGb0YRyI1pgxZi/2S5As7KnIF5V5RBfBFsekBaPDv0DE6B+Q2FhaLynU
XduGyqsnNmg=
--000000000000b32fc705b09f9ec3--
