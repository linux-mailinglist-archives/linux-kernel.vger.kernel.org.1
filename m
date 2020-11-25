Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AE62C36FC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 04:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgKYCz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 21:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgKYCz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:55:58 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55198C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 18:55:42 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id d20so1002171lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 18:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVLUYjo0mTqXMXhyI9y/4N/cU1rDAW9Wrg6NPzTE/+4=;
        b=DApjdGFFu/IxkXaaimxU/0ewXnDvcxY15TGVMdZyW2tvcNQJz/tHsGpKQ66lGMG5KQ
         mLBYocW3+ik856F/vTfGAw0XLMoUWgYMDbh2Oy9XTUErY5jxdrC25LyeZr2tTaPrtEkk
         H/O6sPC1ETyCRxgOi9MckQ1N7c1ZaLL9q7rOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVLUYjo0mTqXMXhyI9y/4N/cU1rDAW9Wrg6NPzTE/+4=;
        b=bv/fF9Ys80AcJ4SmyYxI7p5uyJqvPGRSgYF3lfIA+WdKsmYrAHgAz7NNTjTYXVxmM3
         XpwdEp4xLWU8d4wh9S0H63wk40a2PqCTPTfblZlURpvjfi1DGxJUksPDmQH2RJrkH8Do
         MNkUQthOXPicg2+dhZkEWiS/HJE2/wXlTXFMRjhl9kGLDtNDUozsRnqxP1LWY/JCiEEQ
         MI5+aWYQbc2PCBbU+P+zi+Ql7clMApIynv+ouyPv5NrT4m7RiG+H5d/Bvw0f6D9fq6zq
         mUYk6q9GEXeJtCKtPSlQMi0q6QTNe0mIjgYo9O5NaZ14/zbwXndlhr0wOZas5YvvzjEW
         t1Vw==
X-Gm-Message-State: AOAM532tw5sPhQ+KMGhALYZjkTQ4U/hKJ5tDLIcdQM4gLOZEqgeOxPKn
        Pcn8MXD/Zg+QAq0nv/s/T1vKVSHr5h74BeAsh08fcsSL1skmdQ==
X-Google-Smtp-Source: ABdhPJy4WEJZIECjxTGx6sO6NWcN5uOcPf9AqGtjf0VPYkT/LLuPywiZqNJEqPKv+SCBwbNBMhRA2WDqPqayrq6KyNU=
X-Received: by 2002:ac2:51a4:: with SMTP id f4mr434422lfk.365.1606272940838;
 Tue, 24 Nov 2020 18:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20201124151210.1081188-1-kpsingh@chromium.org>
 <20201124151210.1081188-4-kpsingh@chromium.org> <adaa989215f4b748eb817d15bd3c2e8db2cbee3c.camel@linux.ibm.com>
In-Reply-To: <adaa989215f4b748eb817d15bd3c2e8db2cbee3c.camel@linux.ibm.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 25 Nov 2020 03:55:29 +0100
Message-ID: <CACYkzJ5ZJ_yu=dXM5-jXEO5p5WzpXDT5EdT0agL1pgdNRqGamw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] bpf: Add a selftest for bpf_ima_inode_hash
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 3:20 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2020-11-24 at 15:12 +0000, KP Singh wrote:
> > diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
> > new file mode 100644
> > index 000000000000..15490ccc5e55
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/ima_setup.sh
> > @@ -0,0 +1,80 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +set -e
> > +set -u
> > +
> > +IMA_POLICY_FILE="/sys/kernel/security/ima/policy"
> > +TEST_BINARY="/bin/true"
> > +
> > +usage()
> > +{
> > +        echo "Usage: $0 <setup|cleanup|run> <existing_tmp_dir>"
> > +        exit 1
> > +}
> > +
> > +setup()
> > +{
> > +        local tmp_dir="$1"
> > +        local mount_img="${tmp_dir}/test.img"
> > +        local mount_dir="${tmp_dir}/mnt"
> > +        local copied_bin_path="${mount_dir}/$(basename ${TEST_BINARY})"
> > +        mkdir -p ${mount_dir}
> > +
> > +        dd if=/dev/zero of="${mount_img}" bs=1M count=10
> > +
> > +        local loop_device="$(losetup --find --show ${mount_img})"
> > +
> > +        mkfs.ext4 "${loop_device}"
> > +        mount "${loop_device}" "${mount_dir}"
> > +
> > +        cp "${TEST_BINARY}" "${mount_dir}"
> > +        local mount_uuid="$(blkid -s UUID -o value ${loop_device})"
> > +        echo "measure func=BPRM_CHECK fsuuid=${mount_uuid}" > ${IMA_POLICY_FILE}
>
> Anyone using IMA, normally define policy rules requiring the policy
> itself to be signed.   Instead of writing the policy rules, write the

The goal of this self test is to not fully test the IMA functionality but check
if the BPF helper works and returns a hash with the minimal possible IMA
config dependencies. And it seems like we can accomplish this by simply
writing the policy to securityfs directly.

From what I noticed, IMA_APPRAISE_REQUIRE_POLICY_SIGS
requires configuring a lot of other kernel options
(IMA_APPRAISE, ASYMMETRIC_KEYS etc.) that seem
like too much for bpf self tests to depend on.

I guess we can independently add selftests for IMA  which represent
a more real IMA configuration.  Hope this sounds reasonable?

> signed policy file pathname.  Refer to dracut commit 479b5cd9
> ("98integrity: support validating the IMA policy file signature").
>
> Both enabling IMA_APPRAISE_REQUIRE_POLICY_SIGS and the builtin
> "appraise_tcb" policy require loading a signed policy.

Thanks for the pointers.

- KP

>



> Mimi
>
