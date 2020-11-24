Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0702C2F91
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 19:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404163AbgKXSFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 13:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403976AbgKXSFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 13:05:21 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E03C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 10:05:20 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t37so18076510pga.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 10:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MojZ6jBt5OtLG/TzqV1ikTl1Qn52hc3qcvA84UUjHgc=;
        b=XtKeqZZhpnmsowACg6eCy8+dXSRPaqofN5kDDCPcXyPf8cXWgFBoTxHE8tdABjWWNz
         GeB0dq21fPxOAIfRLwzD3y98/6ND936fZ2rAsti01SabWExNHeoqFiLtWvcPTGs8HUq5
         s8rCE3AnRuocqdjAKWwrgu5x5JcS2tTe2JudijQKbVRVWSmK72IYNZPf9/B+sIexLjnG
         hAivTbYxN12JuQ4WsLv3lUp/lmLe9g8tRjDU8yVHU0yILNUN/iVq42wSndgD/NO6b/Ra
         Pm4ln9rbO1VZZjveTEcxja1b6rxaCNbHoD9XZkceob7OV30qkF7SKb3eVzbwtKXm1rwp
         C48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MojZ6jBt5OtLG/TzqV1ikTl1Qn52hc3qcvA84UUjHgc=;
        b=haQ9dL1SzMgOHWn8qa0lEpoFCaNMZ3CjYbe4rFU8MES51o1YtP3WH5PmaLn4dQ3y9D
         PjAoAF8u/SYGFCAeiMYiBygsgmklh+7OGU9QkcqK4IP3+bEGiEz6X3i1pkGLm62FHGfV
         7DhTVXNCukX9IyY2yvCcl+aXI5Nd4c5jmRaVZO0Xo3JnQU1+N7jd+3e/edXMYu6IaNPg
         BievzYO1Pp8i73lPxmsAIVTnHmEm0EeAxh2R1Fp4Hlx1YxcV5p15oa/zsc+m6q5oLPKA
         fr+0XvjMcsS8ADeh68Qph3uJuLmfey0Slgo68wV3RhmUoO2A8xAzoy/U8d5jjztwVT8D
         80sA==
X-Gm-Message-State: AOAM531GOtPMX5mOLbWcRURAPDsZpOuSxii/rz4TKk1/6bcFJMcv+jKy
        nOhJt9aZ0GW8xHIKDv/OWJc6hpB9X3Dmeg==
X-Google-Smtp-Source: ABdhPJz+vigXFKxAiOebAxx2A58tItECtUZIscE9Uf7ItNW9NEji3jQ6SFOtdDvl1EGswW4NLlo6Uw==
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr6415879pjp.68.1606241120026;
        Tue, 24 Nov 2020 10:05:20 -0800 (PST)
Received: from google.com (h208-100-161-3.bendor.broadband.dynamic.tds.net. [208.100.161.3])
        by smtp.gmail.com with ESMTPSA id a3sm15359736pfo.46.2020.11.24.10.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 10:05:19 -0800 (PST)
Date:   Tue, 24 Nov 2020 10:05:16 -0800
From:   William Mcvicker <willmcvicker@google.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        kernel-team@android.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v1 0/2] Add support to capture external module's SCM
 version
Message-ID: <20201124180516.GA737971@google.com>
References: <20201121011652.2006613-1-willmcvicker@google.com>
 <20201123090257.GB6334@infradead.org>
 <20201123221338.GA2726675@google.com>
 <20201124093117.GA21089@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124093117.GA21089@linux-8ccs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 10:31:18AM +0100, Jessica Yu wrote:
> +++ William Mcvicker [23/11/20 14:13 -0800]:
> > On Mon, Nov 23, 2020 at 09:02:57AM +0000, Christoph Hellwig wrote:
> > > On Sat, Nov 21, 2020 at 01:16:49AM +0000, Will McVicker wrote:
> > > > These two patches add module support to capture an external module's SCM
> > > > version as a MODULE_INFO() attribute. This allows users to identity the SCM
> > > > version of a given kernel module by using the modinfo tool or on the device
> > > > via sysfs:
> > > 
> > > As this obviously is of no use for in-tree modules it falls under the we
> > > don't add code to support things that are not in tree rule and has no
> > > business in the kernel.
> > 
> > Hi Christoph,
> > 
> > Ah sorry, I didn't intend this to come across as only for external modules.
> > That just seemed like the easiest way to explain how the scmversion attribute
> > can be different from the vermagic. We mainly need this for in-tree kernel
> > modules since that's where most our drivers are. Let me re-phrase this with
> > that in mind. Basically, I like to look at this as an improved version of the
> > existing srcversion module attribute since it allows you to easily identify the
> > module version with a quick SCM version string check instead of doing a full
> > checksum on the module source.
> > 
> > For example, we have a setup to test kernel changes on the hikey and db845c
> > devices without updating the kernel modules. Without this scmversion module
> > attribute, you can't identify the original module version using `uname
> > -r`. And for kernel modules in the initramfs, you can't even use modinfo to get
> > the module vermagic.  With this patch, you are able to get the SCM version for
> > *all* kernel modules (on disk and in the initramfs) via the sysfs node:
> > /sys/module/<mod>/scmversion. This also works the other way around when
> > developers update their kernel modules to fix some bug (like a security
> > vulnerability) but don't need to update the full kernel.
> 
> Hi Will,
> 
> If this were also intended for in-tree kernel modules, then why do
> intree modules only get the UTS_RELEASE string in their scmversion
> field, which basically already exists in the vermagic? Or do you plan
> to change that?
> 
> Jessica

Hi Jessica,

Thanks for asking! The reason in-tree kernel modules get the UTS_RELEASE string
is for a few reasons:

(1) It contains the SCM version (since UTS_RELEASE has that).
(2) It allows you to get the SCM version via the sysfs node (useful for modules
in the initramfs).
(3) It helps identify that that particular kernel module was in-tree when
originally compiled.
(4) Using UTS_RELEASE also allows us to respect the privacy of kernels with
"# CONFIG_LOCALVERSION_AUTO is not set" by not including the SCM version in the
module scmversion attribute.

Now, if we don't care about knowing if a module was in-tree or not (since
we only care about in-tree modules here anyway), I can update the patch to have
a consistent format regardless of in-tree or external. Personally, I like the
UTS_RELEASE version better because it gives me more information from the sysfs
node which is useful when debugging issues related to modules loaded in
initramfs.

Thanks,
Will
