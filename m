Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1AF26C99A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgIPTOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbgIPRka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:40:30 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 909172076D;
        Wed, 16 Sep 2020 11:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600254274;
        bh=lFBiwHtK6AFv8tNn9lt8ZEVeIHstWsf8bfrVPBe167s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HbYou1Uleay1Ns6v0dFkL5dnxzRbUGZu7vtK5KaOuXn1vEPoAs/hq7W22Oqf3iNRk
         tId7LuzG4GsxuZogz5khUK/cuiDXnX032ijC+sUGAz5gjWzltocw0umRVB3iwXeO7p
         CiHcnYuyT15VsDEakoe6glA6S4awoOzQYK+JNs2o=
Date:   Wed, 16 Sep 2020 13:05:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/14] TCPM support for FRS and AutoDischarge
 Disconnect
Message-ID: <20200916110508.GA825656@kroah.com>
References: <20200901025927.3596190-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901025927.3596190-1-badhri@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 07:59:13PM -0700, Badhri Jagan Sridharan wrote:
> First of all apologies for mixing up the patch version as noted by
> Heikki and Greg. All of them were v1's but since I was manually adding
> the version numbers I mixed them up. Using the --reroll-count option
> now. Updating the patch version to v6 (highest version number in the
> previous patchset + 1) to avoid confusion.
> 
> I also rebased on to off of the recent usb-next tip:
> 5fedf0d295d3 (origin/usb-testing, origin/usb-next) Merge 5.9-rc3 into usb-next
> Which had the following changes causing merge conflict:
> 3ed8e1c2ac99 usb: typec: tcpm: Migrate workqueue to RT priority for processing events
> 6bbe2a90a0bb usb: typec: tcpm: During PR_SWAP, source caps should be sent only after tSwapSourceStart
> 
> Addressed comments from Heikki and Randy which have described in the
> individual commit's change history as well.

First 3 patches now queued up, thanks.

greg k-h
