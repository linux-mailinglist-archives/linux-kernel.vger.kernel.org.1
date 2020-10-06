Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D95284C8D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 15:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgJFNaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 09:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFNae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 09:30:34 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16119C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 06:30:33 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t18so3568227ilo.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 06:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nxheCNIBk27fHu3SnrcxO61/+dDNHmsAZ+V/ZMEW1FQ=;
        b=eLcRUkG2BvfNZR/tqkzKvzcLDyo/A6+biNXbVCHVso0GMsT/R5rqPedObSgaDe9L8c
         x0z6llgsNEBoVzsgqpOaFfZ9JiPbsICxfW7EziTA0SG+UDfU3+TFx8yDCkzQZ9jwPUDW
         9KrsUS04E/nlNYGV9xNGXMqKnYGYloDBAJCgd0gq2oRHsItaZLz32OR39N1g24dgtK9j
         eGJbie/Rfp+ie0uFEvMdRtZG0FFl9mjwlbnWOcsw9xz143eu8uMwTFT5Hew5ULmMJvDN
         iTSkUk7cXgD6eFxPcmNfN4cFenqUrB0GGG2jvdiZyds5NoT2vnOIN0ZmzoAeoWoe87d6
         GIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nxheCNIBk27fHu3SnrcxO61/+dDNHmsAZ+V/ZMEW1FQ=;
        b=d/82/VFHYBZUCBZ64hoPwglrm6xBGhN5kRA8dJbFYWJp/JGYSSmP7xTPJx7DHegVdg
         6MDb7Z/BuIFzBVeeygs5Pvi4asNpZz9a23DAnEd+SGiU+dIjeA/r7gl6YjA0LkepIwRt
         gIoNqDbI2mXIhmkn8xDzh2I+gZUhoJkHcJcTW71kUs9HMO2Yq5Wn1DTQ7OquSKul9lfp
         ErsyuLodFBbVBuGrGcgW17VxICD3L2DpxhQSwX2etOwp6dAsVFQcx0uZsB2Og8zVtwBq
         oaSER8yHHkFYwkazdVYIhRuYCN9sKiepViv63yjwUf4Unbzw8HRG81j3hvnWGQgDrjEH
         YMuQ==
X-Gm-Message-State: AOAM531WsICH6pOQdIBspgq9K3/npoimldh8foufmjtc7gPPgRfri9J9
        9cdKTNa1qqh8ePYjaz5QxLDmJg==
X-Google-Smtp-Source: ABdhPJyYNSRknztkzPHBli45617VnJ7M3gsP6dNnh3SvCD7hO2X+20R3o/jN3dD0tjR3bCKJt301AA==
X-Received: by 2002:a05:6e02:547:: with SMTP id i7mr3863840ils.0.1601991032389;
        Tue, 06 Oct 2020 06:30:32 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y26sm1511291iol.24.2020.10.06.06.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 06:30:31 -0700 (PDT)
Subject: Re: [PATCH V7 0/2] percpu_ref & block: reduce memory footprint of
 percpu_ref in fast path
To:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
References: <20201001154842.26896-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8b0828ee-8b86-a505-842b-f86968591bfe@kernel.dk>
Date:   Tue, 6 Oct 2020 07:30:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001154842.26896-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 9:48 AM, Ming Lei wrote:
> Hi,
> 
> The 1st patch removes memory footprint of percpu_ref in fast path
> from 7 words to 2 words, since it is often used in fast path and
> embedded in user struct.
> 
> The 2nd patch moves .q_usage_counter to 1st cacheline of
> 'request_queue'.
> 
> Simple test on null_blk shows ~2% IOPS boost on one 16cores(two threads
> per core) machine, dual socket/numa.

Applied, thanks.

-- 
Jens Axboe

