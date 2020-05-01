Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E48B1C10F2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 12:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgEAKhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 06:37:23 -0400
Received: from foss.arm.com ([217.140.110.172]:38456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728545AbgEAKhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 06:37:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BA4F30E;
        Fri,  1 May 2020 03:37:22 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.7.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8266F3F73D;
        Fri,  1 May 2020 03:37:20 -0700 (PDT)
Date:   Fri, 1 May 2020 11:37:12 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jeremy Linton <jeremy.linton@arm.com>, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, git@thegavinli.com,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] usb: usbfs: correct kernel->user page attribute mismatch
Message-ID: <20200501103712.GA51954@C02TD0UTHF1T.local>
References: <20200430211922.929165-1-jeremy.linton@arm.com>
 <20200501070500.GA887524@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501070500.GA887524@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 09:05:00AM +0200, Greg KH wrote:
> On Thu, Apr 30, 2020 at 04:19:22PM -0500, Jeremy Linton wrote:
> > On arm64, and possibly other architectures, requesting
> > IO coherent memory may return Normal-NC if the underlying
> > hardware isn't coherent. If these pages are then
> > remapped into userspace as Normal, that defeats the
> > purpose of getting Normal-NC, as well as resulting in
> > mappings with differing cache attributes.
> 
> What is "Normal-NC"?

Arm terminology for "Normal Non-Cacheable"; it might be better to say
something like:

On some architectures (e.g. arm64) an IO coherent mapping may use
non-cachable attributes if the relevant device is cache coherent.
If userspace mappings are cacheable, these may not be coherent with
non-cacheable mappings. On arm64 this is the case for Normal-NC and
Normal (cacheable) mappings.

Thanks,
Mark.
