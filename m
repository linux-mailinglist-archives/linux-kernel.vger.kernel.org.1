Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C7C278643
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgIYLs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgIYLs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:48:57 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C9C82083B;
        Fri, 25 Sep 2020 11:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601034537;
        bh=T5j5zqOk5bArZowmj9egtHWODeYXr/9ElczEDUPS190=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=H6wlIDlVRp9P08pSw5ys5zM3PhNUn7yMO/X41Ek6C9saBg4s9IUAbeOZ6twMKy8mo
         4W/ls0u/LjPhXqZCO3ZJCp+qJ7BNEx6ffI+o4Wt5oBon7ZY4PRnEqnhKSSlM7Ac8BL
         PrkrksAkHsnjVC/dMDc3JW0zw9elIUleOT1VSS5A=
Date:   Fri, 25 Sep 2020 13:48:54 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-2?Q?Kamil_Doma=F1ski?= <kamil@domanski.co>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@archlinux.org>
Subject: Re: [PATCH v3] HID: logitech-hidpp: add support for Logitech G533
 headset
In-Reply-To: <CA+oAjKzdmzg2KFuuSOJL35ifHRSCosHW+y4Cm4bmQQQc49GjAA@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2009251347470.3336@cbobk.fhfr.pm>
References: <20200704004745.383271-1-kamil@domanski.co> <nycvar.YFH.7.76.2008310859340.27422@cbobk.fhfr.pm> <CA+oAjKzdmzg2KFuuSOJL35ifHRSCosHW+y4Cm4bmQQQc49GjAA@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020, Kamil Domański wrote:

> Hi Jiri,
> I'm not sure what you mean by "proper changelog that should go to the
> commitlog".
> Is the commit message "HID: logitech-hidpp: add support for Logitech G533
> headset" inadequate?

That's a shortlog. But please provide also brief explanation of what the 
patch does and how. If I apply your patch as-is, this would have gone to 
the git commit as a changelog:

> > > Changelog:
> > >   v2:
> > >   - changed charging status parsing to account for invalid states
> > >   v3:
> > >   - rebased against Linux v5.7
> > >   - changed variable naming in hidpp20_adc_map_status_voltage
> > >     to camel case
> > >   - corrected comment styling in hidpp_battery_get_property
> > >   - dropped usage of test_bit macro in hidpp20_adc_map_status_voltage
> > >     to avoid using `long` type
> > >   - added bit flag definitions in hidpp20_adc_map_status_voltage
> > >
> > > Signed-off-by: Kamil Domański <kamil@domanski.co>

Which is definitely not how kernel commit logs look like -- just take a 
look at the changelogs in the kernel git repository for inspiration.

Thanks,

-- 
Jiri Kosina
SUSE Labs

