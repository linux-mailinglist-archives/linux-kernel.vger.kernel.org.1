Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5ADC219C98
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 11:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgGIJt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 05:49:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgGIJt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:49:56 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1925206E2;
        Thu,  9 Jul 2020 09:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594288195;
        bh=4xTrBWEpeteKomZwBFiUhGoZ8HmLK2087sfPuJRrmO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=euHvKUo0ORLBp6uNsROvKYzge04Bhcvktng/HnwISKVbJYau8d6wBXUoFZpOtXovz
         /huFwIZaEIpvFh+iNt6E1iHAzaLo7o2bmxcahOCkruskUMC9G+afL55TdUgBcH3BfY
         G4QrjTxOoshz1kgASJqRTk9J0EGuqvSSkiPf/v50=
Date:   Thu, 9 Jul 2020 10:49:51 +0100
From:   Will Deacon <will@kernel.org>
To:     sanggil2.kim@samsung.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kernel: Add module symbols _text, _etext.
Message-ID: <20200709094950.GA28361@willie-the-truck>
References: <CGME20200709082408epcas2p4369fa8f06a57c7358be38282aae0f501@epcas2p4.samsung.com>
 <1594283025-4166-1-git-send-email-sanggil2.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594283025-4166-1-git-send-email-sanggil2.kim@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 05:23:45PM +0900, sanggil2.kim@samsung.com wrote:
> From: Sanggil Kim <sanggil2.kim@samsung.com>
> 
> We have a solution to protect kernel code section(autually from _text to
> _etext) by not MMU. In order to do this, we have to know the addresses
> of _text and _etext at runtime.

Interesting! Can you post patches so that we can implement this solution
upstream? Without an in-tree user, we won't be exporting these symbols.

Thanks,

Will
