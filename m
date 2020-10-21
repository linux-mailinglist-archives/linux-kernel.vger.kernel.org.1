Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306DB29505F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502760AbgJUQFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394827AbgJUQFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:05:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3BCC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=zKsjQDbYlpReRkxmyoMcjhZFRH7oUbJY/pHCzDexlA4=; b=CuhF0b9KfwYW2Vx0uEezS3WYEs
        ZKCKpffnBBiyQTOHqraNyjuOqfoLR2bGF/9cwg5Y+aynW5xreMrDoanyCTpYlQDfjaPcpX0RR2cdM
        jEYxYFum1XaZWq5j7vgXsjUnebclns/vpYarw8I4HWsOuMB2vgovDcDoq+Y7bAm0ychwst4epyvKV
        xHfq4x86vIErz1wxFCdM2NBHht97kJQXw9AKTBgTIMpjP8rdbPq4zDtXcmwjiyKWlyqni0P0+yB8H
        KY5HUpzwmWFx9doRuWe9Od9CigPJhFnMA4BaBMNQQ0uDVNaDdSZ0ivshyC27ILS6hGp8/znHqcGot
        S29pjI+A==;
Received: from [2601:1c0:6280:3f0::507c]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVGcE-0001kh-Ff; Wed, 21 Oct 2020 16:05:30 +0000
To:     Ian Rogers <irogers@google.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: lib/test_min_heap.c
Message-ID: <54b2b36d-6288-3260-3426-85d7467ace19@infradead.org>
Date:   Wed, 21 Oct 2020 09:05:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

I was wondering if you recall why lib/test_min_heap.c has

#include <linux/log2.h>

I don't see any interfaces from that header file that are used
in lib/test_min_heap.c.

thanks.
-- 
~Randy

