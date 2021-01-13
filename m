Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F9C2F5537
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 00:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbhAMXa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 18:30:56 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:50406 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbhAMXXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 18:23:36 -0500
Received: by mail-wm1-f52.google.com with SMTP id 190so3034643wmz.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 15:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EAD1NNiUKRbW2AuIhdlRBYCSNPU8MCggmuQy96n9Jb0=;
        b=U41otAga32+X+sqfwVnrK0pKlvJTZdkOP1SL9+sPAoyzdha0Cl1vsGp9G1MftSeytA
         EHrIg0zOlko69kTw5JPRvFQEd3n8pSLh4eo3Bj3yhpDH79CsK/H5wZrUEftge5xA6YEG
         r/Bk+Cnt3c98J+KVcWNQpCtjjWHXUpFtE0vXqzZ5mxxUrHQN00C8IECGNWnIAxBp/+w9
         asmEVO8OSmz0nb/3ybbwlJxnL7qOEjev/T4pxTRIDCXlBeNyQP6u35FeZn6zz9Qazvbk
         Fkb2H38/o4nH47hUfLpCJG7A7INkh0yOu1y6vjLDl9FixUqNykz+IeCOyIRYxQHSslpy
         Uk0A==
X-Gm-Message-State: AOAM530OGWtHPQOYD19N6Id+mmh+w979oTpLQxp3eCzUHTxpBmpzrCA7
        JTGb1Dqcxbk0MU2YL7Z57WBplfuuqtw=
X-Google-Smtp-Source: ABdhPJy2ZWqaykKvD0m1cPrWYZRxWviYEwthitCWx6Agdbk9GelLGMqESJOvz/aHmDP9Jl+LeduhAA==
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr1242466wmj.117.1610580174471;
        Wed, 13 Jan 2021 15:22:54 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988? ([2601:647:4802:9070:e70c:620a:4d8a:b988])
        by smtp.gmail.com with ESMTPSA id q6sm4939299wmj.32.2021.01.13.15.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 15:22:54 -0800 (PST)
Subject: Re: [PATCH] nvme: Constify static attribute_group structs
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210108234147.42151-1-rikard.falkeborn@gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4d516ec7-6a3a-71d0-4781-9fd2fcc95fa6@grimberg.me>
Date:   Wed, 13 Jan 2021 15:22:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210108234147.42151-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
