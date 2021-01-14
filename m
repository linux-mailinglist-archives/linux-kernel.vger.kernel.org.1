Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309AA2F665D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbhANQuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbhANQuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:50:18 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA61C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:49:37 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id g4so2355215ybo.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3flWftvGerUtHOc/UBeXeoAZbOIBV75pAafgEogkVqE=;
        b=esIpWe7U6STmq0pn1F8FzDD3IakFxSohETjST/CdldSpNKdaEf46zdSLVvp0nfiMu6
         Sb5FRPom/tSNscgf7XCFU6QSQuJYhrnHIBS87MJXImNAfWo96EMiP5DMs7PetSp3gzPm
         xgQSxLSq3jRfP3LTuO1ct4nA7LeuMFMKWWtKg3UViCfdvrOZvR1aj04GOaE0aTVJSVkw
         Jf9CoBrmzdjAg4x1ehne0Br0eTltr9ySpVcU5DsVS2jBo7SgpLmDVYrNit2YVSeP6QOo
         VrvdGNGupJ8NfgmbPZhIcafbxCKRb1+NAxx+BpBAZH9xkeB0VuufWaEGalV54K9cJco6
         51uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3flWftvGerUtHOc/UBeXeoAZbOIBV75pAafgEogkVqE=;
        b=QjHYruAOQvNo+7CXzyfSn3SLWl8ByfhDPmhXIKAW74fWDZTsmZ4PQjj5VQBRRBzuCn
         dS5OFXrcWmFPr5+TAsvrhalpcYkciO21C6a4C/+Rg6YP+ylFOMeFgGL9XfMRvWLpqX2E
         kK62V3VI9K1YZqEPzD+bgXDVG76xFbIFNxQ9JXqGAotcFSJtEHezMGUK0sJC6b0lXtXC
         GkpYY9zJPiGTL9BdJ/1ygTX+4t64L8huCyREyGEVUc+devQ4toF6isKEw5BFL/14LvXp
         lkrSNXSIToPCLJg3fKdRQ8IWbYqKkQ07/pM7yVcB1chFYTbef3Fxg6GuWOh3ddw+Ocmw
         GF3Q==
X-Gm-Message-State: AOAM5319mbqf53IcDPsX24RNyZpIqe7BVs0VrZy80kEoPgnCMe3N8zA9
        VYh0kIw3Gpaac4b6RViWaZGPC4LLTo1XiDzUn0QCOw==
X-Google-Smtp-Source: ABdhPJyusiIS68gz/S8pZMJM4tmwMW7sKnfG2jonBk5+w7GNuPdg5lBA2IuvIYn2lGmWuAm31SZgc2j+l3Cq/blGv5M=
X-Received: by 2002:a25:8b8b:: with SMTP id j11mr8659623ybl.310.1610642976862;
 Thu, 14 Jan 2021 08:49:36 -0800 (PST)
MIME-Version: 1.0
References: <20201218031703.3053753-1-saravanak@google.com>
 <20201221161822.572e5cbe@xhacker.debian> <CAHp75VfqL1QuvjCZ7p23e_2qhY3DUgVNaS--Uk1mEoEHsD8GBA@mail.gmail.com>
In-Reply-To: <CAHp75VfqL1QuvjCZ7p23e_2qhY3DUgVNaS--Uk1mEoEHsD8GBA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 14 Jan 2021 08:49:01 -0800
Message-ID: <CAGETcx-=g-qU-A5YO5co52Q02OtKnP6R6Z4YbisiG91R+QkaJQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Enable fw_devlink=on by default
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marc Zyngier <maz@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 11:48 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>
>
> On Monday, December 21, 2020, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>>
>> On Thu, 17 Dec 2020 19:16:58 -0800 Saravana Kannan wrote:
>>
>>
>> >
>> >
>> > As discussed in LPC 2020, cyclic dependencies in firmware that couldn't
>> > be broken using logic was one of the last remaining reasons
>> > fw_devlink=on couldn't be set by default.
>> >
>> > This series changes fw_devlink so that when a cyclic dependency is found
>> > in firmware, the links between those devices fallback to permissive mode
>> > behavior. This way, the rest of the system still benefits from
>> > fw_devlink, but the ambiguous cases fallback to permissive mode.
>> >
>> > Setting fw_devlink=on by default brings a bunch of benefits (currently,
>> > only for systems with device tree firmware):
>> > * Significantly cuts down deferred probes.
>> > * Device probe is effectively attempted in graph order.
>> > * Makes it much easier to load drivers as modules without having to
>> >   worry about functional dependencies between modules (depmod is still
>> >   needed for symbol dependencies).
>> >
>> > Greg/Rafael,
>> >
>> > Can we get this pulled into 5.11-rc1 or -rc2 soon please? I expect to
>> > see some issues due to device drivers that aren't following best
>> > practices (they don't expose the device to driver core). Want to
>> > identify those early on and try to have them fixed before 5.11 release.
>> > See [1] for an example of such a case.
>> >
>> > If we do end up have to revert anything, it'll just be Patch 5/5 (a one
>> > liner).
>> >
>> > Marc,
>> >
>> > You had hit issues with fw_devlink=on before on some of your systems.
>> > Want to give this a shot?
>> >
>> > Jisheng,
>> >
>> > Want to fix up one of those gpio drivers you were having problems with?
>> >
>>
>> Hi Saravana,
>>
>> I didn't send fix for the gpio-dwapb.c in last development window, so can
>> send patch once 5.11-rc1 is released.
>
>
> If you are going to do anything with that GPIO driver, it should be removal of compatible strings from the device child nodes. The driver IIRC never used them anyhow anyway.

We already discussed this in a different thread. Just deleting DT is
not okay. That breaks a new kernel + old DT combo. Upgrading the
kernel shouldn't break a board.

-Saravana
