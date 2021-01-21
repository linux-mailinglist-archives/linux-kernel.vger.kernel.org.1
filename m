Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACE72FF32E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbhAUS37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:29:59 -0500
Received: from mout.gmx.net ([212.227.15.19]:54001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbhAUSYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611253347;
        bh=vjQW4TKGsW2UmvXkX37wzzORNHRYtgG6i43MdHHFZyA=;
        h=X-UI-Sender-Class:Subject:From:In-Reply-To:Date:Cc:References:To;
        b=Ifq3yy+Q7lX4+Xfh1riVy5QJshuBoKgtno4+JF9a+3kdEZEavjT84nBF9nxTpn/iJ
         VPzPpn4/R5HGKFnFuxabUuiDhF7BenSOAeHp/3cWzSOaWufKBMt/+a3j2zYcmmywwi
         iCA7lqGb9kVS/BUm8UYfx5uEAYNLDX25OubSKEas=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.42.0.78] ([83.204.192.78]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBUqL-1lAfLI0U2x-00D2B9; Thu, 21
 Jan 2021 19:22:27 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.5\))
Subject: Re: [RFC PATCH 3/7] arm64: mm: use nGnRnE instead of nGnRE on Apple
 processors
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
In-Reply-To: <f2b1cb981e7c3d42a9f815c2d2be08bb@kernel.org>
Date:   Thu, 21 Jan 2021 19:22:24 +0100
Cc:     Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Stan Skowronek <stan@corellium.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A85F09CC-0203-4560-A65F-F9754535345B@caramail.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-4-mohamed.mediouni@caramail.com>
 <20210121112725.GA21750@willie-the-truck>
 <fdc49d125ef9f520254196509f6c0aa2@kernel.org>
 <20210121124742.GA22123@willie-the-truck>
 <39067FDD-F7D3-4F37-8B43-1A9FCF80EEE5@caramail.com>
 <195e2bfe3a5e5503d9988b517159300e@kernel.org>
 <20210121175525.GB22963@willie-the-truck>
 <f2b1cb981e7c3d42a9f815c2d2be08bb@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.5)
X-Provags-ID: V03:K1:oJoietTKBhqTacvuUkJhKDBzQhk4Fw1I8oOwZyqTy8PuEG05V8p
 ekOb75Wlvcot5alrctaV+g34TthGeQNLyY1TEcs32cx1c1JlfU0LyV5/sVP5TaPCes6jEE5
 2x8HFk4dAsPyUSyVjq/XWEJ++yluOtqfMGDraR+S3bMkxa3zynxgI510dwzCY9575qpGwZx
 R6kBBpJYe5aQMUiCYur4g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:U7hoWESd7vc=:GE0XZFpaUwr7sxDB6iP6KN
 wd8CN6nExOuTnwum7nfBJBjkBgBby5++usJ+JAQ1PW3ZgWW1c1PKo3dG228MmCsq46YzE5yLR
 fVEdvbp+tmwphhNqPFQuaFaL3Wkcj44tYIMjfHNmGBlzdk1YIVoInjCZWvCrHU+ouXMeeUKrs
 brt4KQk+8C72QiXFwgBlUhgQAGhRzdWKREya512/URst8pW4vMmS9w89RS8GRgZlHS/bfIpCJ
 s7NCBDgWzKeR7fIT4z1Lm4p7KwQfxo02NL32TcO91ypvcnPJ4wCyqrIdrqsG+C9ByyDgh4XP9
 8Y2ACZv48iBRiyo0ajpYw6+M3JtMZi+774uDZ5HaW5yVmGj67r3GdnQA8hpUOTjor6a9u9yMa
 bDOgwIhNZEojSD6he3mMwHGcfSxdoza9j9BDu7D6omGdrszLXL3b3UHtBLk0DnOARl9RCy408
 wHVatGClgS/gjXk74ZwZs4RHH4OrVlEpoh4v91y8NX1l+6jwLCczKyiio8iIq3p+rG0LW7A9w
 o/tQSkrY1wz+ENpLWQVLh0hmUrKKugZZYF0lHMSOsWct9UwQpNnUy3g0uvorhUTw+ANZAX6QT
 YUuSg/jVm0QFSMvfVsbLq0FwxF0KqJc4BDIiqQJtnNc6NP7f+Un4xfjpXkdiNZqSP55oNqmZB
 sj69yPVeLRn0AmWAU5eiTSch1S+hlKb6M5miLGbUpYtMJ55Ulb8JB7ocIf4OR5hy6djhSGZCf
 Tv1kDtjpFDInXLfmah34p11DvELAKOYfAm8eafyuxeT99ocVG8FvZslGDO2rBoIyMtiDO3qHj
 E1NNCb4jjFHXtrRzPVEAzSDhNX0rgFJFtmFCzipOIRhmBgyOiI47f6RYrzlc7hudoT4Bawn0E
 h6pvGuwqI3XcT7Zlkl1n/lZyZ3Oajo8ww1bdNiIHM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 21 Jan 2021, at 19:15, Marc Zyngier <maz@kernel.org> wrote:
>=20
> On 2021-01-21 17:55, Will Deacon wrote:
>> On Thu, Jan 21, 2021 at 04:25:54PM +0000, Marc Zyngier wrote:
>>> On 2021-01-21 15:12, Mohamed Mediouni wrote:
>>>> Please ignore that patch.
>>>>=20
>>>> It turns out that the PCIe controller on Apple M1 expects posted
>>>> writes and so the memory range for it ought to be set nGnRE.
>>>> So, we need to use nGnRnE for on-chip MMIO and nGnRE for PCIe BARs.
>>>>=20
>>>> The MAIR approach isn=E2=80=99t adequate for such a thing, so =
we=E2=80=99ll have to
>>>> look elsewhere.
>>> Well, there isn't many alternative to having a memory type defined
>>> in MAIR if you want to access your PCIe devices with specific
>>> semantics.
>>> It probably means defining a memory type for PCI only, but:
>>> - we only have a single free MT entry, and I'm not sure we can
>>> afford to waste this on a specific platform (can we re-purpose
>>> GRE instead?),
>> We already have an nGnRnE MAIR for config space accesses.
>=20
> I'm confused. If M1 needs nGnRE for PCI, and overrides nGnRE to nE
> for its in-SoC accesses, where does nGnRE goes?
>=20
> Or do you propose that it is the page tables that get a different
> MT index?
>=20

That MAIR patch that I added overrides nGnRE accesses to nGnRnE.

Linux tries to access to those SoC devices using nGnRE as the device
memory type without that workaround.

Maybe have a device tree property to override the used device memory =
type
for a given device on the SoC? Or that=E2=80=99s too big for what=E2=80=99=
s at the end just one=20
particular set of SoCs?

But what the hardware wants is accesses to in-SoC devices being nGnRnE
and access to the PCIe BARs being nGnRE.

So both have to be supported=E2=80=A6

>       M.
> --=20
> Jazz is not dead. It just smells funny...

