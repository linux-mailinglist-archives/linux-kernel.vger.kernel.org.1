Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325F1283CA5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbgJEQkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgJEQkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:40:04 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9B8C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 09:40:04 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id z5so8379213ilq.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 09:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dZSZ5kzSBxmgO3EkC+7hniQauMKPKijAIyqy5Tah1xM=;
        b=DMCMYq7tDVZ5xjleAe8GNo8iq5nFxJWkkW69qKE/+Z7shdLawIYWij9p36m5dgiHzk
         uveysvQThLy21q3WF+211cm+a04id1rDsMgA7WwcCHEdgwFCjG6ppu/ZcezKwjbRRxZK
         nCeJeJIOIwOzdOphwb/X/7hwpJVcnn839KCM0rcaBa0tchnlpHwNXbskpMdpnrVkH06T
         G6kvyf6Hvr7BMjS/ULe1F28m6fBbFnkrWLdn4TBa2JSY0LoCc9m9bXg4p4PXhj3w3XcM
         VX8gj+qnRlD0yfpfF51qhOjueh53+Zm7PwW3m1uMMMazAabhlHrE3IqocQ1/IM44iMvY
         /uKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dZSZ5kzSBxmgO3EkC+7hniQauMKPKijAIyqy5Tah1xM=;
        b=oXr3qOVahNIl80DUCB3veokmWVJQ4prd9P9lZ9RpUpxXL4MPUnbXws+EkgcshgMEOB
         34i7DHTDVeq8wvvfOHstpp8HQzCCTpeI79MHfq5QefOGF6qS8LRhgAJ6MSi6814VFJhi
         IPIULTJnZAygir3SMpcSF99wDDGN99dTMQknk6p0bQ7FftCCjLIIRqt7wWBaqfRN/FMZ
         iA7UiuC46QTM5GUu6A42KuInsOXctdrqDMRv/MWMsfTjJIYWEQdmJb/n0+56JGvo5wK9
         1Q7alBxU/UXIrQQ/f3hLJLAfZuwAfVWbjqJ5e5T0RNKt9JLHXBdBvX/ZcxDMcNO+Yvw1
         n2Hg==
X-Gm-Message-State: AOAM533jEm65I8OhKUIbu3xbMfd2TJTM2VMTTa3c6nIqJJgmeL1XTfjp
        wDAkjAys+Er4CQ6DvwFz0N+ghA==
X-Google-Smtp-Source: ABdhPJzFKmWiZiCSBV85FRdV06a1XMN4EpaIO48aWFIp6OAILZ+bb7mP1aNHeIHPBPIFxi1ILmriVg==
X-Received: by 2002:a05:6e02:11:: with SMTP id h17mr194184ilr.300.1601916003509;
        Mon, 05 Oct 2020 09:40:03 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a21sm194797ioh.12.2020.10.05.09.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 09:40:02 -0700 (PDT)
Subject: Re: remove bdget() as a public API
To:     Christoph Hellwig <hch@lst.de>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com
References: <20200925160618.1481450-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <20798679-80af-50a7-64f7-0af1af78ab16@kernel.dk>
Date:   Mon, 5 Oct 2020 10:40:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200925160618.1481450-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/20 10:06 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series first cleans up the somewhat odd size handling in
> drbd, and then kill off bdget() as a public API.

Applied, thanks.

-- 
Jens Axboe

