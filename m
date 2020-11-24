Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164052C235B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbgKXK4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:56:35 -0500
Received: from wind.enjellic.com ([76.10.64.91]:33422 "EHLO wind.enjellic.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgKXK4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:56:34 -0500
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 0AOAtmjV020691;
        Tue, 24 Nov 2020 04:55:48 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 0AOAtlwf020690;
        Tue, 24 Nov 2020 04:55:47 -0600
Date:   Tue, 24 Nov 2020 04:55:47 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, bp@alien8.de, cedric.xing@intel.com,
        chenalexchen@google.com, conradparker@google.com,
        cyhanish@google.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH v40 00/24] Intel SGX foundations
Message-ID: <20201124105547.GA19930@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20201104145430.300542-1-jarkko.sakkinen@linux.intel.com> <20201121151259.GA3948@wind.enjellic.com> <5ac4eccb-fcf9-eed3-fcec-b8b6bf56bb39@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ac4eccb-fcf9-eed3-fcec-b8b6bf56bb39@intel.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Tue, 24 Nov 2020 04:55:48 -0600 (CST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 21, 2020 at 08:25:23AM -0800, Dave Hansen wrote:

Good morning, I hope the week has started well for everyone.

> On 11/21/20 7:12 AM, Dr. Greg wrote:
> >> Important Kernel Touch Points
> >> =============================
> >>
> >> This implementation is picky and will decline to work on hardware which
> >> is locked to Intel's root of trust.

> > Given that this driver is no longer locked to the Intel trust root, by
> > virtue of being restricted to run only on platforms which support
> > Flexible Launch Control, there is no longer any legitimate technical
> > reason to not expose all of the functionality of the hardware.

> I honestly can't understand what the point of this is, and I mean
> that on multiple levels.

I'm sorry the issue is elusive to you but that doesn't mean it isn't
technically relevant or grounded.

It also doesn't mean this issue isn't relevant to the kernel community
at large.  I have been active in Linux since late 1991 and my
perception was that technical honesty was always the imperative, hence
my last e-mail on this subject.

> First of all, there's not a coherent description of the problem
> you're solving with ~700 lines of code and the treatise you wrote
> here instead of a changelog.

A number of points.

While I'm flattered, I cannot ethically accept the fact that the
e-mail I wrote amounted to a treatise.  To do so would do injustice to
the likes of Euclid[0], Descartes[1] and Newton[2] among notable
others.  From a literary metric perspective it wouldn't rise to the
level of a monograph let alone an essay on the subject.

With that behind us.

There was a full changelog with the patch, the e-mail essentially
wrapped the changelog and patch with a cover letter that was directed
at being responsive to the issue of including the SGX driver in the
kernel.

If you would have clicked on the link that I provided, which I will
replicate below:

ftp://ftp.enjellic.com/pub/sgx/kernel/SFLC-v41.patch

You will get a fully 'git am' compliant patch, including a changelog.

The changelog was written in a parlance consistent with someone who
would have a basic understanding of the technology under review.  If
this entire review and vetting process is being done absent that kind
of understanding, then the case can be made that the kernel
development process has larger issues on its hands.

Lets be honest though, that is not the case here, we have been talking
about this issue for over a year, everyone involved with this
technology knows what the problem is.

Since LKML is copied, the basic issue is as follows:

1.) SGX as a technology is designed to execute code and operate on
data in a manner that is confidential to inspection and impervious to
modification and control by the kernel.

2.) The mindset of the driver developers is that the kernel should be
the ultimate authority on what SGX is allowed to do.

The two world views are inherently and technically incompatible and
lead to a potential security dilemma for the kernel.  We simply
advocate for an additional level of cryptographic security that
supplements, not replaces, kernel controls to address this issue.

Issue #1 isn't theoretical.  The Linux Foundation feels there is
commercial value to this concept, as do the primary signatories
(Intel, GOOGLE, Microsoft, IBM/RedHat, Alibaba, ARM, Huawei) to the
Confidential Computing Consortium, all of which have a desire to
economically exploit the notion of a generic Trusted Execution
Environment such as SGX.

So this is either a legitimate technical issue that needs to be
addressed or these companies and their customers are on a fools
errand.

> Second, is the point here to distract folks from testing the branch
> in the tip tree?  Or, is it to show appreciation to maintainers by
> giving them more of the thing they love: code to review?

Overall, given the extremely small number of people that understand
this technology end to end, let alone who can effectively test it, our
involvement was driven by:

Quis custodiet ipsos custodes?

With respect to the maintainers, I'm sure it is a thankless job.

However, if you are getting paid to review and maintain kernel code
then one needs to review kernel code or find a different job if it is
too thankless.  I have plenty of thankless things to do in my job but
I do them since it is my job.

Our patch has two external functions of around 30 lines (~1 screen)
each that impact the driver.  The bulk of the 700 lines, all in one
file, is boilerplate code, largely replicated for each instance,
needed to read/write sysfs files and maintain four, nearly identical,
linked lists.  If this is an insurmountable review burden then the
kernel development process has larger problems on its hands.

Have a good day.

Dr. Greg

[0]: The Elements
[1]: Discourse on the Method
[2]: Opticks

As always,
Greg Wettstein, Ph.D, Worker          Autonomously self-defensive
Enjellic Systems Development, LLC     IOT platforms and edge devices.
4206 N. 19th Ave.
Fargo, ND  58102
PH: 701-281-1686                      EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"I can only provide the information, I can't make you hear it."
                                -- Shelley Bainter
