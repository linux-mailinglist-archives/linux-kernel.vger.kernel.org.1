Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94587257407
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 09:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHaHBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 03:01:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgHaHAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:00:43 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A62C52072D;
        Mon, 31 Aug 2020 07:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598857242;
        bh=EcZv20DHA3WGRVOyn/DrIh4cwXXjXx1WSRdJvt2CjGY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=yPBApWzPA8OH4OcQV/KZ/PL/qPkZYYMTy5XdBnn/tIJTeqk5h/9sZKfZv/U4Ucuh9
         o8nTlT0xqMmZenPxd0tUKoPpYc+kMhWHuYVnPq+wZv5QsvKn/67ZUlFxtCsW9E+ENP
         L4fwUHh/t6KNH3IuSa/J69EJ04Va+sIoL4crJ0Aw=
Date:   Mon, 31 Aug 2020 09:00:39 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-2?Q?Kamil_Doma=F1ski?= <kamil@domanski.co>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@archlinux.org>
Subject: Re: [PATCH v3] HID: logitech-hidpp: add support for Logitech G533
 headset
In-Reply-To: <20200704004745.383271-1-kamil@domanski.co>
Message-ID: <nycvar.YFH.7.76.2008310859340.27422@cbobk.fhfr.pm>
References: <20200704004745.383271-1-kamil@domanski.co>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jul 2020, Kamil Domañski wrote:

> Changelog:
>   v2:
>   - changed charging status parsing to account for invalid states
>   v3:
>   - rebased against Linux v5.7
>   - changed variable naming in hidpp20_adc_map_status_voltage
>     to camel case
>   - corrected comment styling in hidpp_battery_get_property
>   - dropped usage of test_bit macro in hidpp20_adc_map_status_voltage
>     to avoid using `long` type
>   - added bit flag definitions in hidpp20_adc_map_status_voltage
> 
> Signed-off-by: Kamil Domañski <kamil@domanski.co>

Hi,

I've finally made it to this patch (sorry for the delay), and it looks 
good to me in general (no major concerns with the polling either).

Could you please send me the proper changelog that should go to the 
commitlog though (it's definitely not this 'Changes sice vX ...').

Thanks,

-- 
Jiri Kosina
SUSE Labs

