Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D822C3221
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 21:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgKXUpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 15:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgKXUpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 15:45:53 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6F3C061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 12:45:53 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id d9so313945qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 12:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7bnJlg0pCMXaozI88JAYoUf2eoJblsJDXclZcxtC0/M=;
        b=hwTVUZW81iCSr3MsWXpIZGpVmMSrVSKr+coOsDZm1vYv2MN8GOIncXCu8CPpMTkbrD
         ytgAa7a0APxzZLUnRUpFzBqGZKtOSti3yEcgMBEyAY48nYbvZSXn53M0ZI/yN5HXP7YF
         RbuXJSZCltQ09pZOVNVywwQms+Fksq9lXRc/2R22ZrkdBGOUnth0lvy3TFOCTQ7r9baJ
         633CEiTTEWwm0GzWRh6CHUWJvnojBVB04vDiH5Eo9hPUUMiOX+RvbkQAkqQVIEMpmL0A
         F5nHVdGNHVgiRq+8DnR9O+ZgsGB2AOyi+4HoIg0CrRLlIJ1cfvZS9cKTSb9ZBByv7inv
         BIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7bnJlg0pCMXaozI88JAYoUf2eoJblsJDXclZcxtC0/M=;
        b=DZ9PSZokJbhfYXa7IWle5BQd1b14Xzrin6tzkFShKexYAf5EfzximIG6T0+zErOGjv
         u3MOxjWZoTRkipxywhySUiw+r/rmJGDNQ0/VzH81hffCqb0LW8B0DzWyJE6jWpoITE9W
         aRlxO9G9J02n9O+jrpgFrRnrRtfnZJt5DtyYpqwTPVLIsGzlJuJg3DZq+evKHgkk/U0O
         P62qq60DKoX6TrDNlNKq/G1cn2d82XkjVL+BPtFbvpQOvDjhFzRIQU7/5Dc/WImI3lTp
         UTHIbO3ofjmejaegKyjDOGa22Vc9b9ptJ3br5UxnDjrdbPeLnnwvkK78azGrerV3y6or
         FVXQ==
X-Gm-Message-State: AOAM531TsVik78QTnaaFnSPYvGo8Bqw+szZZM6pCWnOTsTpJKljgH9wQ
        SXvXy2QPyF+pd4ivWgSfoVr6vE4uwcCy8o7gssTzvcp+tJe6u7hz
X-Google-Smtp-Source: ABdhPJxsql7h4UNX9o7XDEJOkLZeMV9cPdUqPr94L2UJCZDSvnu0rPRiOxfzKlw9JaGxm51qnGZoO/ip485E3xRvGFw=
X-Received: by 2002:a25:e805:: with SMTP id k5mr13198935ybd.32.1606250752514;
 Tue, 24 Nov 2020 12:45:52 -0800 (PST)
MIME-Version: 1.0
References: <20201121011652.2006613-1-willmcvicker@google.com>
 <20201123090257.GB6334@infradead.org> <20201123221338.GA2726675@google.com>
 <20201124093117.GA21089@linux-8ccs> <20201124180516.GA737971@google.com>
 <X71NGClOP5Lqg6M5@kroah.com> <20201124183139.GB737971@google.com>
 <X71r+kHD87CV9tcL@kroah.com> <20201124204057.GA1145276@google.com>
In-Reply-To: <20201124204057.GA1145276@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 24 Nov 2020 12:45:16 -0800
Message-ID: <CAGETcx8unBFUHxM67VdOoaWRENGXYoc4qWq2Oir=2rUyJ7F5nA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add support to capture external module's SCM version
To:     William Mcvicker <willmcvicker@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 12:41 PM William Mcvicker
<willmcvicker@google.com> wrote:
>
> On Tue, Nov 24, 2020 at 09:24:26PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Nov 24, 2020 at 10:31:39AM -0800, William Mcvicker wrote:
> > > On Tue, Nov 24, 2020 at 07:12:40PM +0100, Greg Kroah-Hartman wrote:
> > > > On Tue, Nov 24, 2020 at 10:05:16AM -0800, William Mcvicker wrote:
> > > > > On Tue, Nov 24, 2020 at 10:31:18AM +0100, Jessica Yu wrote:
> > > > > > +++ William Mcvicker [23/11/20 14:13 -0800]:
> > > > > > > On Mon, Nov 23, 2020 at 09:02:57AM +0000, Christoph Hellwig wrote:
> > > > > > > > On Sat, Nov 21, 2020 at 01:16:49AM +0000, Will McVicker wrote:
> > > > > > > > > These two patches add module support to capture an external module's SCM
> > > > > > > > > version as a MODULE_INFO() attribute. This allows users to identity the SCM
> > > > > > > > > version of a given kernel module by using the modinfo tool or on the device
> > > > > > > > > via sysfs:
> > > > > > > >
> > > > > > > > As this obviously is of no use for in-tree modules it falls under the we
> > > > > > > > don't add code to support things that are not in tree rule and has no
> > > > > > > > business in the kernel.
> > > > > > >
> > > > > > > Hi Christoph,
> > > > > > >
> > > > > > > Ah sorry, I didn't intend this to come across as only for external modules.
> > > > > > > That just seemed like the easiest way to explain how the scmversion attribute
> > > > > > > can be different from the vermagic. We mainly need this for in-tree kernel
> > > > > > > modules since that's where most our drivers are. Let me re-phrase this with
> > > > > > > that in mind. Basically, I like to look at this as an improved version of the
> > > > > > > existing srcversion module attribute since it allows you to easily identify the
> > > > > > > module version with a quick SCM version string check instead of doing a full
> > > > > > > checksum on the module source.
> > > > > > >
> > > > > > > For example, we have a setup to test kernel changes on the hikey and db845c
> > > > > > > devices without updating the kernel modules. Without this scmversion module
> > > > > > > attribute, you can't identify the original module version using `uname
> > > > > > > -r`. And for kernel modules in the initramfs, you can't even use modinfo to get
> > > > > > > the module vermagic.  With this patch, you are able to get the SCM version for
> > > > > > > *all* kernel modules (on disk and in the initramfs) via the sysfs node:
> > > > > > > /sys/module/<mod>/scmversion. This also works the other way around when
> > > > > > > developers update their kernel modules to fix some bug (like a security
> > > > > > > vulnerability) but don't need to update the full kernel.
> > > > > >
> > > > > > Hi Will,
> > > > > >
> > > > > > If this were also intended for in-tree kernel modules, then why do
> > > > > > intree modules only get the UTS_RELEASE string in their scmversion
> > > > > > field, which basically already exists in the vermagic? Or do you plan
> > > > > > to change that?
> > > > > >
> > > > > > Jessica
> > > > >
> > > > > Hi Jessica,
> > > > >
> > > > > Thanks for asking! The reason in-tree kernel modules get the UTS_RELEASE string
> > > > > is for a few reasons:
> > > > >
> > > > > (1) It contains the SCM version (since UTS_RELEASE has that).
> > > > > (2) It allows you to get the SCM version via the sysfs node (useful for modules
> > > > > in the initramfs).
> > > > > (3) It helps identify that that particular kernel module was in-tree when
> > > > > originally compiled.
> > > > > (4) Using UTS_RELEASE also allows us to respect the privacy of kernels with
> > > > > "# CONFIG_LOCALVERSION_AUTO is not set" by not including the SCM version in the
> > > > > module scmversion attribute.
> > > > >
> > > > > Now, if we don't care about knowing if a module was in-tree or not (since
> > > > > we only care about in-tree modules here anyway), I can update the patch to have
> > > > > a consistent format regardless of in-tree or external. Personally, I like the
> > > > > UTS_RELEASE version better because it gives me more information from the sysfs
> > > > > node which is useful when debugging issues related to modules loaded in
> > > > > initramfs.
> > > >
> > > > We already know if a module was built in-or-out of tree, the "O" taint
> > > > flag is set, so that information is already in the module today, right?
> > > > Can't that be used somehow here?
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > > Hi Greg,
> > >
> > > Let me prefix this with this, I do see the benefits of having a consistent
> > > scmversion format for intree and out-of-tree modules. So I'm happy to fix that
> > > in the next patchset.
> > >
> > > Now, I could be wrong, but I believe the taint flag is only printed when the
> > > module is loaded:
> > >
> > >   XXX: loading out-of-tree module taints kernel.
> > >
> > > or when there's a kernel WARNING or kernel crash. But that assumes you have the
> > > full logs when the kernel booted or you have a full crash stack in the kernel.
> > >
> > > Modinfo does have an attribute that indicates if the module is intree or
> > > not:
> > >
> > > $ modinfo -F intree out_dir/./net/netfilter/nf_log_common.ko
> > > Y
> > >
> > > But that is not queriable via sysfs.
> >
> > Look at the file in /sys/modules/MODULENAME/taint
> >
> > That should show you this value.
> >
> > > Ideally, we'd like to be able to get all
> > > this information via sysfs so that it can be captured in our bug reports.
> >
> > I think you already have it :)
> >
> > This is independent of your "source code id value" idea though...
> >
> > thanks,
> >
> > greg k-h
>
> Thanks for pointing out the taint sysfs node. With that, the only reason I can see
> using UTS_RELEASE over always using the SCM version is to immediately get the
> extra version information like the 5.10.0-rc4 part without having to extract
> that from the SCM version. For scripting reasons and consistency I think it
> would be best to just stick to using the SCM version alone and not UTS_RELEASE.
> Unless someone objects, I'll update v2 to use the SCM version (not UTS_RELEASE)
> always.

sysfs files are supposed to be simple and follow one value per file in
general. Also, the documentation needs to be simple too. Documenting
two different formats for the same file would be very odd. So +1 to
what Jessica said and +1 to your decision to keep it consistent.

-Saravana
