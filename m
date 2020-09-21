Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4142721AF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgIULAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:00:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgIULA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:00:26 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2747A206E5;
        Mon, 21 Sep 2020 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600686026;
        bh=uXPte3OmIEx5H4vZeCdjgjUGW4WAufAICRuu1vTB99s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SVxJivcTqGyjO6H4SS/0pbaQvKeD9XgwnaB3xcFy5zofHgVT9KYU14minzRFZ5g5p
         +G7Ls6v8hOfMmEFeO7sMRB11l9bTq+6x5ezjJcoQ4ZEItM+0R2PYJmYD0n0nIHWhgn
         DA9pE9Xa2BXPbWHMydmkNrjc+pl7FGsiKhCIBOXE=
Date:   Mon, 21 Sep 2020 12:00:21 +0100
From:   Will Deacon <will@kernel.org>
To:     Anthony Steinhauser <asteinhauser@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, catalin.marinas@arm.com,
        maz@kernel.org
Subject: Re: [PATCH] PR_SPEC_DISABLE_NOEXEC support for arm64.
Message-ID: <20200921110020.GA2139@willie-the-truck>
References: <20200717110532.238533-1-asteinhauser@google.com>
 <20200907171825.GB13281@willie-the-truck>
 <CAN_oZf29J-DMF04EhQf=29CzV5zrPT+L6HchZcG-CDt=MjFf4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN_oZf29J-DMF04EhQf=29CzV5zrPT+L6HchZcG-CDt=MjFf4A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anthony,

On Sun, Sep 20, 2020 at 03:25:23AM -0700, Anthony Steinhauser wrote:
> > As a heads up: I'm currently reworking most of this, and hope to post
> > something within the next two weeks.
> 
> Sure. Let me know whether you want to implement the
> PR_SPEC_DISABLE_NOEXEC support directly or whether this patch would be
> relevant even after your rework.

I posted a first cut at the rework on Friday:

http://lists.infradead.org/pipermail/linux-arm-kernel/2020-September/602709.html

so maybe you could take a look at implementing PR_SPEC_DISABLE_NOEXEC
on top of that? If not, please let me know and I can look into it as I
think it should be reasonably straightforward.

Will
