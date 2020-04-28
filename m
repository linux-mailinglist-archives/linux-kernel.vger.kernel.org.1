Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85B21BC016
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 15:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgD1Nrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 09:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgD1Nrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:47:47 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E56EC03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 06:47:47 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EAB5944A;
        Tue, 28 Apr 2020 13:47:45 +0000 (UTC)
Date:   Tue, 28 Apr 2020 07:47:44 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/gup.c: Updating the documentation
Message-ID: <20200428074744.72e9e976@lwn.net>
In-Reply-To: <20200427122606.dc29c381f6da47831a40d365@linux-foundation.org>
References: <1588013630-4497-1-git-send-email-jrdr.linux@gmail.com>
        <20200427122606.dc29c381f6da47831a40d365@linux-foundation.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020 12:26:06 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 28 Apr 2020 00:23:50 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:
> 
> > This patch is an attempt to update the documentation.
> > 
> > * Adding / removing extra * based on type of function
> > static / global.  
> 
> I don't think so, unless this is a new kerneldoc convention?

Nope, no new convention here.  If it's a kerneldoc comment, it should be
marked as such.  The kerneldoc utility can sort them out later.

jon
