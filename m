Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F97B2F32A9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbhALOI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:08:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbhALOI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:08:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CB2A22CE3;
        Tue, 12 Jan 2021 14:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610460496;
        bh=GU2OUDwQAS/ozK28aHf+AlRMOPJl2sUBfdsvWNDlLMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6C6JctjlxF8VILZDzH552rsITFEJAkzJDHKm2pr+zKdaf+Eq3rxz5M/sfXl8yOS8
         9Yd4C2LI1Xe092JLEwUrQpWjeEfwYcNjqoy9eomPmEbofPJfWqEoM3GSvJC/3XFQY0
         gfeH+OF++G7lEcFyTNxK5Mv6UpsBeLldZd3R2eZV87LbHRN9M5Oe7QRC/3mYAyozRf
         QMVJ+q818GNMngvlFhjtcB+jM5xLSsXix0FjHc5mwhndA/u09jHKG2MYyxTkPW7PiI
         frB53qvHUh+IbgEoAekMgi3MSRVdfAOjrGYo704QjwgkM2dTfRj2dDBXBOryK+GqB5
         jGeMQNjC/LxcA==
Date:   Tue, 12 Jan 2021 14:08:12 +0000
From:   Will Deacon <will@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] kernel.h: Drop unneeded <linux/kernel.h> inclusion
 from other headers
Message-ID: <20210112140811.GE9277@willie-the-truck>
References: <20201028172826.41635-1-andriy.shevchenko@linux.intel.com>
 <20201030083356.GC32163@willie-the-truck>
 <20201030110606.GN4077@smile.fi.intel.com>
 <20201228213726.GG4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228213726.GG4077@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Dec 28, 2020 at 11:37:26PM +0200, Andy Shevchenko wrote:
> On Fri, Oct 30, 2020 at 01:06:06PM +0200, Andy Shevchenko wrote:
> > On Fri, Oct 30, 2020 at 08:33:56AM +0000, Will Deacon wrote:
> > > On Wed, Oct 28, 2020 at 07:28:26PM +0200, Andy Shevchenko wrote:
> > > > There is no evidence we need kernel.h inclusion in certain headers.
> > > 
> > > Did you run some tools to determine this or is it just a hunch?
> > 
> > I read files manually. So, closer to the latter.
> > Also I rely on 0day and other CIs that didn't show anything for a long time.
> 
> Will, any recommendation what should I run to be solid about this change?

Sorry, I don't have any good suggestions here. That's actually why I asked,
in case you happened to have something to make these sort of changes less
error-prone! So I'm not trying to block this change, it's just a shame that
it's not easier to do.

Will
