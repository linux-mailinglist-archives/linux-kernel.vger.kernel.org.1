Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC622EF814
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 20:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbhAHT0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 14:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbhAHTZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:25:59 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8297FC061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 11:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=F97J5VLKsbqx0rKnfqu6jABi/26hhNbiwCYs3v8Tn/w=; b=Wl6Ut2/hwF7pz/Y8PECwRVGBK0
        ju2HnnYYMPfTcaCA3Y86GN5R9Nmch+Qm/taE3F1nAd2iBQJYy0sRdVyfbnciLM1g8tIsS7tMq2tgP
        tJ/EmBQnzV3sepUfvqb5RJ8xyVDoK5u1ix4s+RfekyjdsWUZRrMf+IA3Jo0XMtlK/K4DXgV9epZcS
        IisQWnVlmUDF9hznPWmOpMyQFRqdldoN68h56xJysBtxJrO/D8zkJSbmxL28EWEeSJgsYT/YtDYBD
        /i6WZFiTTxht3yy75inu5L6oOqJivT0x9PetRoGtYWuLKKpM5jf7v2r5rwxvHsHfmAeTaXJB0OxmI
        RhB51hPA==;
Received: from [2601:1c0:6280:3f0::79df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxxNt-0005Pn-5w; Fri, 08 Jan 2021 19:25:17 +0000
Subject: Re: lkml.org issues
To:     Phillip Susi <phill@thesusis.net>, linux-kernel@vger.kernel.org
References: <87a6tj5j6x.fsf@vps.thesusis.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <304d6a18-c56e-0ad5-6dcc-800bf7813cf7@infradead.org>
Date:   Fri, 8 Jan 2021 11:25:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87a6tj5j6x.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/21 11:19 AM, Phillip Susi wrote:
> Does anyone know where you can report issues on lkml.org?  There's a
> link to have it forward you a copy of mail but it has a capcha and the
> capha is broken.
> 

Historically it has been: Jasper Spaans <j@jasper.es>

Note that most of us are moving away from lkml.org and are now
using lore.kernel.org and specifically lore.kernel.org/lkml/
for LKML archives.


-- 
~Randy

