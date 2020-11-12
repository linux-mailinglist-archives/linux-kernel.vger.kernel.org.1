Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6265F2B04FE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 13:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgKLMfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 07:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgKLMfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 07:35:11 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC265C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 04:35:11 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id a18so4417560pfl.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 04:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rCwShEJ1S536/xkh+3GVTeVZejAQE5Qc7zpd9NfWzKc=;
        b=rT055RtV0Roeh796iKXSoZstP4XRY/SULcBe4BuxustrpZgcALNdZ8HiPiH/YTecSU
         KLzWCLYTmK8jPi+uETG8qARh50vqoyNxtejELdTTlLvXAyEsZgETKi4PCxyZRPay+8W+
         QeQIFFNAoLaa1askGv0Rz35sX728BgzkEvZEjLS7Tc6++xV1fGmg3Ue3pocG7V1BR1M1
         ABrlDJaw4rmsgRzpPPmf0tINz2LNj/rxAOAwPIoLAlYI9adBgtanTx2z9cN6FwJ/jnPC
         kf7BFoE4agHuavAMY0WQqPVR3rMHBu1CQkOCYmRMslUWmUFVFpG6r5BHlaeaYFYlow9M
         AvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rCwShEJ1S536/xkh+3GVTeVZejAQE5Qc7zpd9NfWzKc=;
        b=bsmhToVWqlrJZKrf5ces9dhUx8RlfWHC9MBgwCvennqyQYDQjc3Pk4NeXA4sdQgiP8
         fQ1qh4NGTre0LbyHH4+w8V1/GXDSlyiaTLWwN9v/ImMIflS1DI/UMU94wHqz6En6Xsbu
         GEWTyCfjSIvSZpMmchilZmt+yhSC7Z3RSYbAXxjs4b5VX1XR4Q4O9fNaK07pCFYr7G8W
         ePZplUKOQqCXgyzg/ZDltBFmWmUi3MnfhDTEP4StA897dKoqd04TELttxlCPIzIot++v
         mfXq/cXq3DIPGQ+yYo+kbYvJBBTr2CQKwez20AV05QuG39XFMwK8xNBDNgovFF85xeH0
         xALg==
X-Gm-Message-State: AOAM531jySfeCIRCsueuj8vksKCJOb6JEdeBHgPCVTdjWJ0LioS71rg7
        8tu4ETpkr8JJShkay6gCYAwTTmwgVMojFDkB
X-Google-Smtp-Source: ABdhPJwEWXQmdfWWt2Kb7Nh6DvVqJ2jakGN1wK2g/4uM/H4V/S8hu7ZSxj/LjaPWt8JczWrXHoV7mw==
X-Received: by 2002:a17:90a:f292:: with SMTP id fs18mr9286237pjb.222.1605184511235;
        Thu, 12 Nov 2020 04:35:11 -0800 (PST)
Received: from [192.168.11.16] (softbank126112255110.biz.bbtec.net. [126.112.255.110])
        by smtp.gmail.com with ESMTPSA id s10sm2425237pjn.35.2020.11.12.04.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 04:35:10 -0800 (PST)
Subject: Re: ac0e958a00:
 Kernel_panic-not_syncing:stack-protector:Kernel_stack_is_corrupted_in:run_init_process
To:     kernel test robot <oliver.sang@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        0day robot <lkp@intel.com>, lkp@lists.01.org
References: <20201112071145.GC17067@xsang-OptiPlex-9020>
From:   Rob Landley <rob@landley.net>
Message-ID: <87765a0e-3a49-d437-4010-4848b8ece199@landley.net>
Date:   Thu, 12 Nov 2020 06:46:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201112071145.GC17067@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/20 1:11 AM, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):

Blah, switched from strlcpy to sprintf due to the lack of spaces and didn't
adjust the size.

(And yes, the compiler's lifetime analysis should free the stack space before
the tail call, and I'd assume exec restarts the stack anyway.)

Second-attempt-by: Rob Landley <rob@landley.net>
---

 init/main.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/init/main.c b/init/main.c
index 130376ec10ba..e92320816ef8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1328,15 +1328,16 @@ static void __init do_pre_smp_initcalls(void)
 static int run_init_process(const char *init_filename)
 {
 	const char *const *p;
+	char buf[512], *s = buf;

 	argv_init[0] = init_filename;
-	pr_info("Run %s as init process\n", init_filename);
-	pr_debug("  with arguments:\n");
-	for (p = argv_init; *p; p++)
-		pr_debug("    %s\n", *p);
-	pr_debug("  with environment:\n");
-	for (p = envp_init; *p; p++)
-		pr_debug("    %s\n", *p);
+
+	for (p = (void *)envp_init; *p; p++)
+		s += sprintf(s, "%.*s ", (int)(sizeof(buf)-(s-buf)-2), *p);
+	for (p = (void *)argv_init; *p; p++)
+		s += sprintf(s, "%.*s ", (int)(sizeof(buf)-(s-buf)-2), *p);
+	pr_info("Run init: %s\n", buf);
+
 	return kernel_execve(init_filename, argv_init, envp_init);
 }
