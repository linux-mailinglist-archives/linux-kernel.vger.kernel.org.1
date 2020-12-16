Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113242DC366
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 16:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgLPPsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 10:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgLPPsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 10:48:36 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E184C06179C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 07:47:55 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id w18so10520415iot.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 07:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dsUdMt3elLnLhHpjUMmHSgKb+jK8/Q+XkCcYb65d6H8=;
        b=a8xk4VHLbgY/7YE6M65uEnOLeFyG51dM1svLyeiQa03r90JVHp/sqG8zxiSW2xr+jj
         VS0HoFwJl9YrbUcXiIGWXyaW7nb1CMarpOhhiHv6p42J1WLHYb9yxA7X46KWhSBlY25W
         +851g4fafLZS8U7PqZLOUUNoHFhci0jt2gZMfvWiDbUG9AbRzUchxo5LBejw9AjIMNb0
         LikQ/MyYy4eRic/LRbx7gGPqtmX33BMdO2DqXl4wSHDbRZ00yes5C69kQ0gaY+j23KR+
         /FWZhuuD+ThiryH+Ull3tW8XC565HQIoHif1EzJX3HYeina0iszQlh92suDQ6Th2K3mY
         PtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dsUdMt3elLnLhHpjUMmHSgKb+jK8/Q+XkCcYb65d6H8=;
        b=IFaPKQdVIAUt/UB9KePnZ7GzKdrJTvSfkELpZj1IkJcr+U0vrhNkrXya4ogsePo2Ic
         m9XowO62GeiWpPZIVnizWX7Mcm52yLbKEC5yfPYaONkfIGyXoV39joNume90n8kzwZ1b
         0rM+6CClrFYZnHfdYzBd3NjtyQUxW0kIT+ec10fH7Cy34rfYgc5w73MbH/+jDVlNpDze
         ZSW7Nbd3v/4aj9ijRHaqVUJx+bGT8F7bPdaEW1MWxF5PhmGN4Rro5GklWauIN9TOW+S7
         Au1WOcAqD/1z9tf7dFPQnOGGCyqAHdpzBndQLgZTgdzLeHMKNPIkdfyQm/7kQSLVD/Gp
         98vQ==
X-Gm-Message-State: AOAM533z5HH0hWJHdPmEs9PHs/UUM7TWhSBX7xQB/WDNX2inwUq/GEnT
        MEz0QX2AJsiXkdMeLesrdNoORQ==
X-Google-Smtp-Source: ABdhPJwxGQ7xFQdW/UJttZzPjXJn5YuaIjYFK48rzhEyhZICoqU1gykblinNwbreDVZ++HEW18syMg==
X-Received: by 2002:a05:6638:2a5:: with SMTP id d5mr43495814jaq.92.1608133674293;
        Wed, 16 Dec 2020 07:47:54 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v22sm1489979ila.84.2020.12.16.07.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 07:47:53 -0800 (PST)
Subject: Re: [PATCH v2] blk-mq: Remove 'running from the wrong CPU' warning
To:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
References: <20201130101921.52754-1-dwagner@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <65f4cd1b-d629-7bf3-36c9-e503efb53c97@kernel.dk>
Date:   Wed, 16 Dec 2020 08:47:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201130101921.52754-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/20 3:19 AM, Daniel Wagner wrote:
> It's guaranteed that no request is in flight when a hctx is going
> offline. This warning is only triggered when the wq's CPU is hot
> plugged and the blk-mq is not synced up yet.
> 
> As this state is temporary and the request is still processed
> correctly, better remove the warning as this is the fast path.

Applied, thanks.

-- 
Jens Axboe

