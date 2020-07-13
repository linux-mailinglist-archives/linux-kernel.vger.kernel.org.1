Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0726E21BF90
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 00:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgGJWKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 18:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgGJWKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:10:37 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1657C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 15:10:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w17so2792944ply.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 15:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=aibEP9PY7qjIXvWY9ybATGaYnLNWOzVMnBkuiR7TDf8=;
        b=HEBvePuVhen5zXWxLZJ5MAw3GFOvOn+W3aT7QHZHcK+np34JnSw3feprmqOcn1MN9x
         4lfLK7rdc6DHLOHjgyBt/ym41ksnQK1EaXiNbS741pAYHB/MHGmGNEW0KfJUZLoAqui/
         3aWQJJlU6S2r8xMzEuTOkhCa581xCJayzSRAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aibEP9PY7qjIXvWY9ybATGaYnLNWOzVMnBkuiR7TDf8=;
        b=mRbUHJkfc8r7IYbX94lW5Wu0dRXIE65PgVAOZshrYMgLauxniUn7xw5GTLkpf2JaaI
         qzydJWspanIDFSBEUMV734q00xZHdclFdKXqw29m08+vCbb7jmxL7obEWe9Y6XjxXlFp
         BN1LNMKOOTnHhUDdcsLY00BKFR1yurO7xkhcFqhCoDj+b9Bh9/sMUk7Pp/U+xqdRbYEG
         91akCqJU+H7it+VWEyB+7YWIpsEbErmy4hod48PjShvLnjb/uyRg95FnMJJNPJtTyNvN
         MKf6fwlhnYenWmkJKtmHvaM7MBVkIsb9qLUHVg6opNHdb/1iF5fas/hO2XyCTbkenk4C
         Ubcg==
X-Gm-Message-State: AOAM531yKIsFJ5fdc6Iw5zOmeAWZ7yEsJgSxIQMT4D8CNjZFlMjdmeFP
        GTwmjt5k/5jw67Airbqsd55zgg==
X-Google-Smtp-Source: ABdhPJxbbcxiC7pv6AKukkgRqnx/C9JlUCW130ayKY6GUpNOmDEGE7VxHmt1k7S1K07Qf6rL/fxJ0A==
X-Received: by 2002:a17:90a:a60a:: with SMTP id c10mr8349447pjq.117.1594419037224;
        Fri, 10 Jul 2020 15:10:37 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b22sm6392055pju.26.2020.07.10.15.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 15:10:36 -0700 (PDT)
Subject: Re: [PATCH 2/4] fs: Remove FIRMWARE_PREALLOC_BUFFER from
 kernel_read_file() enums
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200707081926.3688096-1-keescook@chromium.org>
 <20200707081926.3688096-3-keescook@chromium.org>
 <3fdb3c53-7471-14d8-ce6a-251d8b660b8a@broadcom.com>
 <20200710220411.GR12769@casper.infradead.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <128120ca-7465-e041-7481-4c5d53f639dd@broadcom.com>
Date:   Fri, 10 Jul 2020 15:10:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710220411.GR12769@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-07-10 3:04 p.m., Matthew Wilcox wrote:
> On Fri, Jul 10, 2020 at 02:00:32PM -0700, Scott Branden wrote:
>>> @@ -950,8 +951,8 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>>>    		goto out;
>>>    	}
>>> -	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
>>> -		*buf = vmalloc(i_size);
>>> +	if (!*buf)
>> The assumption that *buf is always NULL when id !=
>> READING_FIRMWARE_PREALLOC_BUFFER doesn't appear to be correct.
>> I get unhandled page faults due to this change on boot.
> Did it give you a stack backtrace?
Yes, but there's no requirement that *buf need to be NULL when calling 
this function.
To fix my particular crash I added the following locally:

--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3989,7 +3989,7 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char 
__user *, uargs, int, flags)
  {
      struct load_info info = { };
      loff_t size;
-    void *hdr;
+    void *hdr = NULL;
      int err;

      err = may_init_module();
>

