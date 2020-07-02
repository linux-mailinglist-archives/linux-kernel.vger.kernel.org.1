Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A81212F4F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 00:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgGBWMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 18:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgGBWMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 18:12:09 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4002C08C5C1;
        Thu,  2 Jul 2020 15:12:08 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8F05D2D3;
        Thu,  2 Jul 2020 22:12:08 +0000 (UTC)
Date:   Thu, 2 Jul 2020 16:12:07 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] many-files Documentation patch
Message-ID: <20200702161207.082d42e5@lwn.net>
In-Reply-To: <ca6d7248-df70-4a39-3cbe-b49f286d5e50@infradead.org>
References: <ca6d7248-df70-4a39-3cbe-b49f286d5e50@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 15:05:01 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> This patch series eliminates/corrects many doubled words, such as
> "the the", "of of", "with with", and "and and".
> It mostly drops the doubled word, but sometimes it modifies one or two
> words so that they make sense.
> 
> 
> Can (will) Jon merge this patch series or do I send many separate patches
> to relevant subsystem maintainers?
> or trivial?

I'd have to see the actual patches, of course, but assuming it makes sense
and doesn't create a mess of conflicts it should be something I could
apply.

Thanks,

jon
