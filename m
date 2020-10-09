Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFAB289160
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 20:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbgJISqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 14:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387507AbgJISqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 14:46:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A19C0613D5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 11:46:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y14so7587471pfp.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 11:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DvcPVK52TeNGe98XcbxvkqT3utUuhvx8w1/It1iKwEY=;
        b=2B2IcuvnFVgxHqo1kutPy1Gw0AqK79pzvXF6mUZX3GfTzQ/i31LqvwPiAIknrVTBSC
         a6gbVSFp34Ic3S4oG5bbubPTfvqv2NfdryMsXx6uoMHudUtqpjpJqmXkYn75oAL24SWC
         5a6D1kD0A2SX6mZRVoE5ClYo6KpbFXLW78FnPwL8URFtR8FgAY9ha3/sbvftE7y/wAOa
         DsuZlEVfEKvuoModoTWjcIemDCp1nKuF2OBXhU4wh21y6+/mtU8u4euj0B+4HYTtLS1f
         FJnblch/iSmgukYy3cPTn15LzV433HDSi2OOlIGcgco5/SjcGuwvsUufGOaRWYJzGaHc
         hP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DvcPVK52TeNGe98XcbxvkqT3utUuhvx8w1/It1iKwEY=;
        b=YUgSMVnpVlTnQ25BPomf44ChQpC4ysiBhcm/gkfC3x9si8x+ZNXI1fSSMu+QD+TpOJ
         jssRvcBcGWShfAu+DTpjuNU/M0g/vqJY62ZW7Y3b/Luf71rkBxUSQ01MnP7z4Ei5ROJM
         OPWd2pYmHaSXExpLVzegyZpCVwdd9LjQLbGnDJsyRQMZ4DeSdv07gfbNVi96h4wE/lD9
         OLPfu63SpcCJLrkv1t0cHvWoLpUvIgE+l0ONshzzlh4GNJmOxkytvrLIu7kAwc1NA5Uf
         Q4+dHCkEbkK+Au2rma3Qy8hWn4xx651aBgi5LknjwOv3+X/S+2Z28mFsxHgGUUmTa1Pu
         vvDg==
X-Gm-Message-State: AOAM532OLh2ZT97Ic11AF+CYcSBcC7iU3ZLbmMKMpATsh2QEr0vosB+l
        1dKazb3ChF2kau30LK6JVHCqVg==
X-Google-Smtp-Source: ABdhPJwf8GOLGvume3xRY7oSa3O7Uo2JdCRLzeltY01exD4qH4O2ABj6D2+2Mcc+VMZHneC/88DTlg==
X-Received: by 2002:a62:7f08:0:b029:155:79a4:1364 with SMTP id a8-20020a627f080000b029015579a41364mr6748421pfd.38.1602269206388;
        Fri, 09 Oct 2020 11:46:46 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id p6sm12674785pjd.1.2020.10.09.11.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 11:46:45 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: move cancel of hctx->run_work to the front of
 blk_exit_queue
To:     Yang Yang <yang.yang@vivo.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     onlyfever@icloud.com
References: <20201009080015.3217-1-yang.yang@vivo.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ab2c4655-0ae0-f5c8-2d59-5e699fe9059e@kernel.dk>
Date:   Fri, 9 Oct 2020 12:46:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201009080015.3217-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/20 2:00 AM, Yang Yang wrote:
> blk_exit_queue will free elevator_data, while blk_mq_run_work_fn
> will access it. Move cancel of hctx->run_work to the front of
> blk_exit_queue to avoid use-after-free.

Applied, thanks.

-- 
Jens Axboe

