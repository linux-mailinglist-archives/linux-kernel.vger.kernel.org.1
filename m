Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87422254D2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 02:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgGTAFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 20:05:20 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39308 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgGTAFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 20:05:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 831E92A114;
        Sun, 19 Jul 2020 20:05:14 -0400 (EDT)
Date:   Mon, 20 Jul 2020 10:05:16 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: Replace HTTP links with HTTPS ones
In-Reply-To: <98c2eed7-8d3e-a542-84af-492cf3efc313@al2klimov.de>
Message-ID: <alpine.LNX.2.23.453.2007200928180.8@nippy.intranet>
References: <20200717184240.79799-1-grandmaster@al2klimov.de> <alpine.LNX.2.23.453.2007181258320.92@nippy.intranet> <d4c73203-56ed-820f-82ee-c239d7976d33@al2klimov.de> <alpine.LNX.2.23.453.2007191659150.8@nippy.intranet>
 <98c2eed7-8d3e-a542-84af-492cf3efc313@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jul 2020, Alexander A. Klimov wrote:

> Just tell me either of these:
> 
> * You'll apply these changes of mine as-is
> * You won't apply these changes of mine at all
> * I shall undo particular changes (which ones?) and/or change the commit 
> message (how?) before you apply the others
> 

That's up to Geert or Joshua, as they are the official maintainers.
