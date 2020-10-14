Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5842628DBE4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgJNIoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgJNIog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:44:36 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86285C041E79
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:04:52 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c141so2246538lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pf3x5FQ2Hko6YqhQN9kgFTiejFjVKhvZJfNVeKZw1dk=;
        b=Kp4HeBXANtokvXrl09ID7Gb7drH4Y/YQ7KCe+FQcw7JwCrTGJVmRIHNJ3HYnhII1z1
         uKvN0yWtuxaniACzu0GawEcT7SN+4DVB/MsWb3tv2wYX5Bo0PLgr9wGwEFJF8qcTD+6B
         g+sVpKFodwHxvYMalBoaDEjWkbx+85Rya7l/V9REiD3lwa0DWP09rwuDUE6OUlDRHxJd
         yFns5ZAYoKtIrtW2ByRkNyIPDxyZ+HYl14IUx9CV7iKMIFGDSQb9zZpENE2hFazQFaS3
         ti0F3EvaRDOma0PJudtu21+hU2owm9eQ/HGzeFC1uozqdkpx18TDspU5QoT1kI6xa7I6
         mfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pf3x5FQ2Hko6YqhQN9kgFTiejFjVKhvZJfNVeKZw1dk=;
        b=NMc/pNrWcxy6VD9/RwddRn34EnMNykmkg5+ETZTccRX+PWhj6rIWpGlppuRhX+A3ru
         N1IpV5DiTioiWUmXPbAmf9ELndmfNiy+BCj/TfLgaV4RMnZa8eBFjEFgmgQI3hxi1yWQ
         QSAvyPhSU9aVWHnQRvrEtZKOZTQnDpkrXdVEaHgJobl8Chesh9bteCtVKbqXnZ9CNgLO
         5QYZCBgGSg/neX2EheeX+aS6RLRSVfks6T7OUj598ianpBGn06E8lg5w6J6FqdYx3/HG
         7GOgG0NGFplaeXWFHeZ7Io5EKYVI01YF8tKaWbXl/6UsD5M1X9Y6tMppILw4X4Y4vNaK
         pJcw==
X-Gm-Message-State: AOAM530iwHtI54/eZI4dNxf4JU2spDYE4lGwaOBU2HvTKUY9zqxMid6o
        6Hu9BIXiN0S3XQdnEdwbLQfGV3qdWT8+YXvIFBK9PQ==
X-Google-Smtp-Source: ABdhPJwUNqL6pxBPKJhENn4EMBbasizfbH9aWcTfQHyxUtLN/SrDj0oBIxmxE46DT4Xqqk3bzmvOpyvJxQiJa9x+qYI=
X-Received: by 2002:a19:c88c:: with SMTP id y134mr730515lff.283.1602651890782;
 Tue, 13 Oct 2020 22:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <1602065268-26017-1-git-send-email-sumit.garg@linaro.org>
 <1602065268-26017-2-git-send-email-sumit.garg@linaro.org> <20201013014304.GC41176@linux.intel.com>
 <CAFA6WYN1n_x1wUefXEf-4Y+bUZybNAMeD9cirvz4WQnK2E7djw@mail.gmail.com> <20201013115918.GB141833@linux.intel.com>
In-Reply-To: <20201013115918.GB141833@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 14 Oct 2020 10:34:38 +0530
Message-ID: <CAFA6WYMvqmCVjjb9vW0y+_2+AtoGUE0ZvwBhc4F=4Es-94redA@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] KEYS: trusted: Add generic trusted keys framework
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        Luke Hinds <lhinds@redhat.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Oct 2020 at 17:29, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Oct 13, 2020 at 04:23:36PM +0530, Sumit Garg wrote:
> > On Tue, 13 Oct 2020 at 07:13, Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > >
> > > On Wed, Oct 07, 2020 at 03:37:45PM +0530, Sumit Garg wrote:
> > > > Current trusted keys framework is tightly coupled to use TPM device as
> > > > an underlying implementation which makes it difficult for implementations
> > > > like Trusted Execution Environment (TEE) etc. to provide trusted keys
> > > > support in case platform doesn't posses a TPM device.
> > > >
> > > > Add a generic trusted keys framework where underlying implementations
> > > > can be easily plugged in. Create struct trusted_key_ops to achieve this,
> > > > which contains necessary functions of a backend.
> > > >
> > > > Also, add a module parameter in order to select a particular trust source
> > > > in case a platform support multiple trust sources.
> > > >
> > > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > >
> > > This is exactly kind of place where I think static_call() should be
> > > taken into use, which is a v5.10 feature [1]. For background and
> > > context, I'd read [2].
> >
> > This looks like an interesting feature. But I am not sure about the
> > real benefits that it will provide in case of trusted keys. If we are
> > looking at it performance wise then I think the gain will be
> > negligible when compared with slow TPM communication interface (eg.
> > SPI, I2C) or when compared with context switching involved in TEE.
> >
> > Also, it requires arch specific support too which currently seems to
> > be limited to x86 only.
>
> Please, do not purposely add indirect calls, unless you  must. Here it's
> not a must.
>
> static_call() is the correct kernel idiom to define what you are doing
> in this patch. arch's will catch up.

Okay, fair enough. I will try to use it instead.

>
> > > The other thing that I see that does not make much else than additional
> > > complexity, is trusted_tpm.ko. We can do with one trusted.ko.
> > >
> >
> > Current implementation only builds a single trusted.ko module. There
> > isn't any trusted_tpm.ko.
> > -Sumit
>
> You're right, I'm sorry. I misread this:
>
> -static void __exit cleanup_trusted(void)
> +static void __exit exit_tpm_trusted(void)
>  {
>         if (chip) {
>                 put_device(&chip->dev);
> @@ -1257,7 +1029,11 @@  static void __exit cleanup_trusted(void)
>         }
>  }
>
> -late_initcall(init_trusted);
> -module_exit(cleanup_trusted);
> -
> -MODULE_LICENSE("GPL");
> +struct trusted_key_ops tpm_trusted_key_ops = {
> +       .migratable = 1, /* migratable by default */
> +       .init = init_tpm_trusted,
> +       .seal = tpm_trusted_seal,
> +       .unseal = tpm_trusted_unseal,
> +       .get_random = tpm_trusted_get_random,
> +       .exit = exit_tpm_trusted,
> +};
>
> Please remove "__init" and  "__exit" for the functions as they are used
> as fields as members of a struct that has neither life span. That messed
> up my head.

Okay.

>
> Please use a single convention for the function names. It would
> be optimal to prefix with the subsystem name because that makes easier
> to use tracing tools:  trusted_tpm_<callback name> would work.
>

Okay.

-Sumit

> /Jarkko
