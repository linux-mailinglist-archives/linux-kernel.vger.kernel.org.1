Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D674D1D4937
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 11:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgEOJPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 05:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgEOJPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:15:37 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E71FE2065C;
        Fri, 15 May 2020 09:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589534136;
        bh=yaqrlmYZ6yjMLlrZvFZybqiLMRW1MJGt/LMSQ8POTcE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=U0NfGqgxuvI63L89Pc/dnwbXfLiDyCvPZ2PKy6mZEYtuzUtmfiUtLrMacAGgc3q5j
         GOj6z8DNFzwp39xbTHT3ZKZmWjDTOjZHyQ/dWZrerwFmKl2RuN73KYSlxcgO/a+z4d
         HEi18x0qvi3XmESC3DMsewKHWjv/mmHtaS5Qh6tk=
Date:   Fri, 15 May 2020 11:15:33 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH] MAINTAINERS: add lib/livepatch to LIVE PATCHING
In-Reply-To: <20200515084410.67821-1-kamalesh@linux.vnet.ibm.com>
Message-ID: <nycvar.YFH.7.76.2005151115130.25812@cbobk.fhfr.pm>
References: <20200515084410.67821-1-kamalesh@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020, Kamalesh Babulal wrote:

> Add lib/livepatch to list of livepatching F: patterns in MAINTAINERS.
> 
> Suggested-by: Jiri Kosina <jikos@kernel.org>
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Applied, thanks Kamalesh.

-- 
Jiri Kosina
SUSE Labs

