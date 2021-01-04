Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED6E2E97B5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbhADOx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:53:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbhADOx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609771952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xjC8GYFC/6L0JquqhhaPV/62lfJ54zDw2S27L9Vi/vE=;
        b=PJvOC/Z2JbPdi7aXvPK5pFA+V41C6qg1FDLYgUJkEU0yP0f/NBaQXktgAzf7pYFnJx51Qe
        DIt4vNh0VjhJFso6V0/3WeBVtw7RaFvMpl1Asszja59Un10lxQ6nDPNhMT7zfKUZnL5HIE
        pghbq8DJ7tHZkmHX39kaNBGtknFsLfU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-_WFychYoP0W7AumaEDGbdQ-1; Mon, 04 Jan 2021 09:52:29 -0500
X-MC-Unique: _WFychYoP0W7AumaEDGbdQ-1
Received: by mail-ed1-f70.google.com with SMTP id h5so12302050edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 06:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xjC8GYFC/6L0JquqhhaPV/62lfJ54zDw2S27L9Vi/vE=;
        b=gegRNkAKX9YWXp9SgBAOGxBOduQUIhLn08VepncLpfgTSjBFVWz/j/l2qwMbJmTV+/
         7vNV2zQnA7GW+5otri5ews4NObKC6TlYgHz0+dnoVDLBnHzkefwEZSQlfoKUZuvYCBlR
         V0HTxGvlyWcv+wwscpCuV11upC8UMGME+MHCT7CIiORxRstPPwUbHjNTBP50QSsl5R4p
         nOzYrpkX/SDtBE+pMuqHgz7uYqobiwTCS3WBLNL5e/h7aa5QvWQjCN1a7XUGYmE7McGK
         SOR2wWbmnjVs9qxii35D8yU8w+JGwOT0IHcvjY0fudnBR/EWORnWJpC345ooO2jRk85a
         zO6Q==
X-Gm-Message-State: AOAM531FcSIFLZHpzjjVT7BqH6JXmv23CNJbSzrYLo+PHFFNp7sBio15
        KBF8PdeFUHJjNxVWrEcfXTEZ0daAA7HA3SSAzwL5XQdtPgUtSAGgACXKY4l3V+ds0m3o6pKIdxs
        papm7hjTA7KB8rP8lVfLGc9q5
X-Received: by 2002:a17:907:28d4:: with SMTP id en20mr67897984ejc.196.1609771948041;
        Mon, 04 Jan 2021 06:52:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2uB+EYPco2g6aPflUX0+3cdyjyc8HRN3ARn3cWCVeTYllhLz8r5+lxE8sslyBmVczP/Ti7g==
X-Received: by 2002:a17:907:28d4:: with SMTP id en20mr67897972ejc.196.1609771947876;
        Mon, 04 Jan 2021 06:52:27 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id a2sm16537106ejt.46.2021.01.04.06.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 06:52:27 -0800 (PST)
Subject: Re: drivers/platform/surface/surface3-wmi.c:60:14: warning: variable
 'status' set but not used
To:     kernel test robot <lkp@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <202012291140.j73hBz45-lkp@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <184b4ec6-65f1-5a22-487b-20cc0fb1b587@redhat.com>
Date:   Mon, 4 Jan 2021 15:52:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <202012291140.j73hBz45-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/29/20 4:58 AM, kernel test robot wrote:
> Hi Maximilian,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dea8dcf2a9fa8cc540136a6cd885c3beece16ec3
> commit: f23027ca3d48b6f93c5994069fb25b73539fdf34 platform/surface: Move Surface 3 WMI driver to platform/surface
> date:   9 weeks ago
> config: x86_64-randconfig-r001-20201221 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f23027ca3d48b6f93c5994069fb25b73539fdf34
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout f23027ca3d48b6f93c5994069fb25b73539fdf34
>         # save the attached .config to linux build tree
>         make W=1 ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/platform/surface/surface3-wmi.c: In function 's3_wmi_query_block':
>>> drivers/platform/surface/surface3-wmi.c:60:14: warning: variable 'status' set but not used [-Wunused-but-set-variable]
>       60 |  acpi_status status;
>          |              ^~~~~~

I guess fixing this would require something like this:

From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] platform/surface: surface3-wmi: Fix variable 'status' set but not used compiler warning

Explictly check the status rather then relying on output.pointer staying
NULL on an error. This silences the following compiler warning:

drivers/platform/surface/surface3-wmi.c:60:14: warning: variable 'status' set but not used [-Wunused-but-set-variable]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/surface/surface3-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/surface/surface3-wmi.c b/drivers/platform/surface/surface3-wmi.c
index 130b6f52a600..4b7f79c0b78e 100644
--- a/drivers/platform/surface/surface3-wmi.c
+++ b/drivers/platform/surface/surface3-wmi.c
@@ -63,6 +63,10 @@ static int s3_wmi_query_block(const char *guid, int instance, int *ret)
 
 	mutex_lock(&s3_wmi_lock);
 	status = wmi_query_block(guid, instance, &output);
+	if (ACPI_FAILURE(status)) {
+		error = -EIO;
+		goto out_free_unlock;
+	}
 
 	obj = output.pointer;
 

Maximilian, can you review and/or test this fix please ?

Regards,

Hans

