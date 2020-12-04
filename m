Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAB42CF668
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 22:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgLDVtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 16:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgLDVtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 16:49:25 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D33C061A51;
        Fri,  4 Dec 2020 13:48:45 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 98614380;
        Fri,  4 Dec 2020 21:48:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 98614380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1607118524; bh=k2+DIdhwq28GwEjSlStCKGaU/e6fUD8OEo91hxeS9K4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q1L5nwnnDx3hZncTResuCPFE8VN3zvIncAp3NUrAKqTnxj2FGsn4j3OULUUybbUtu
         Iy4tPJp6E1zbH1lm/zPjOebniv9PZ7BdXFeMbresZMhbC8KNg1tdwxrYo29aRWaWk9
         o0QhvjwQvyAcrUtcWC8X2HwC9A0xz6A6AbPRfEU7KnDVcGBqgfjSrlvuIjqlUAGHXO
         Vp2zmVXStPYvnAL8WZFTUNzeLeBQLwpDA6jXlupw5iBcUwzKZ8JBwXit2RWnG8wvLN
         QlZQzpcRfmHS0klkjgpADaDTN3uO76YC3h1BTaKiBuqT+vG4qOlEAdQ/Dav6vhQQcr
         mvTR/uii4jszQ==
Date:   Fri, 4 Dec 2020 14:48:43 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] improve get_feat.pl output when all features are
 displayed
Message-ID: <20201204144843.1ed3b988@lwn.net>
In-Reply-To: <cover.1607095090.git.mchehab+huawei@kernel.org>
References: <20201203153642.594afd85@lwn.net>
        <cover.1607095090.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Dec 2020 16:32:27 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> As requested, those patches improve the output of the script, when all features
> are displayed.
> 
> The first patch was already posted as-is at v3.
> 
> Patch 2 is optional. IMO, it makes more sense for the admin guide to show
> the architectures where the features are OK, then TODO, and finally the
> ones that are incompatible with the features. I already sent it together
> with a comment.
> 
> Patch 3 is new: it tries to reduce the width of the table, in order for it
> to better fit on a terminal. With the patch, the number of columns were
> reduced, in order to better fit at console output. Before the patch, the
> output takes 281 lines with 158 columns (total size: 38.9 kB). 
> After the patch, displaying all features require 439 lines and 92 columns
> (total size: 37.6 kB).

OK, this is much improved, thanks; applied.

The one last thing I would do is stick "valign=top" on all the table
entries, but we can leave the shed a different color for now :)

Thanks,

jon
