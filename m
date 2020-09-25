Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69895278ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 16:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgIYOTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 10:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbgIYOTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:19:11 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AC2C0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 07:19:11 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id x16so1919330pgj.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Izvn14aXCOd8rlHi8gt8/prckjwG/92/E8+p6vMMqzM=;
        b=QZx7q7gI1poaxI+iNpfTHOEPysawBMN6ILpWj8VDRHvig1MWbXDH9Q/Ejh/VGdMY6V
         XhsSRSgLJ3vyBUW4G6v5lGczlnBrfrfGUTY6Io4kTHSOwwPeeq67+GUlO0pvSbpcSc8G
         UQSaYijRBt6BeZMDv8AdtAKiNqO1VevLatKGi1HCrNW5g8jU/dNWe2se7vKcQ5smC1Kh
         pE6mdkVNLv/zO4pT+cJM9rz/VL4qgjegnLWF0CSvnNA3YX8nzt9KdJQrxarNDFpNgyxb
         mdM7GAKDG1dsnTN8AV+yDCM9QF/vXMl36U6209JvGiLAPdEQelB4a/A4/bJ7gb2XykBg
         PFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Izvn14aXCOd8rlHi8gt8/prckjwG/92/E8+p6vMMqzM=;
        b=DwH8Ck1pTOGjK1OzYhu9V43jXVUlKQG34ujF0w+z7iCrmYq/dbBZvEMaUsUukoJcf7
         fNeaNuldBaKbPwK5TlQBe77NSRjzdI3ywEu4/9hdSl+dHupDbb3/FFtas5iJuV1fOgVD
         dj5QMVyG8nE5TJuI3cRIYMuvzgeyC/1A+f1JSbijcLQbhSkl0udg1ekUzC9fiSLSwfmU
         KWSqMpxtUvPdvwujCerdbBjSGlVZUMOOYvaWeL0oPoIYCfSu+7fRZs+KQ4Tja7W1xGzR
         yNmOlcodUwDH/8Iz/kGlBrjN90h+SI7lvNN4yBIpwV5ni/TuRPIroE8NHFvyofqXWj0B
         OG8w==
X-Gm-Message-State: AOAM5331h8UieCX2NkVh4Q8NFa9mF/UUiaMZOGx+BUeTnDnvY6PX+cCr
        pWX+fH0GAnlQpVwBB+B144KHRQ==
X-Google-Smtp-Source: ABdhPJwRr/FwQpe7dKk8pmg8H/cUjDmWIFuRPHGSosKhPuxMlj+z/HBIhpQTLB9cSGSc+hfMahv5og==
X-Received: by 2002:a63:e057:: with SMTP id n23mr213338pgj.87.1601043550492;
        Fri, 25 Sep 2020 07:19:10 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j19sm2930829pfe.108.2020.09.25.07.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 07:19:09 -0700 (PDT)
Subject: Re: clean up is partition checks
To:     Christoph Hellwig <hch@lst.de>
Cc:     dm-devel@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-ide@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
References: <20200903054104.228829-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7a0600d8-d886-c546-378c-5298a16e979c@kernel.dk>
Date:   Fri, 25 Sep 2020 08:19:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903054104.228829-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 11:40 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series add a new helepr to check if a struct block_device represents
> a parition, and removes most direct access to ->bd_contained from
> drivers.

Applied, thanks.

-- 
Jens Axboe

