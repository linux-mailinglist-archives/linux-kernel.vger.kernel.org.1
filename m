Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5260323D4F7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 03:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHFBJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 21:09:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36881 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHFBJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 21:09:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id k8so8078943wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 18:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wQjU/+p004cIm7TtzbC2U5gKniFLY4qm4G2m16tzq0s=;
        b=b66X86jxvylGSj/qc+d9kgx1ZCq2uuU0oxFg3VGUynb6bBJXianvo56gVY47R2VMom
         2x3DfBQsgQPSXbWjfDAsy31Fki2AclD9dQNjejWGw0ksh4Kmq2Bva0kVVbJfjgnwLk/s
         sTJMT8XHGhVsnquMiVxlb+iGi2pGZwx7USTIAC9Rp78uccOxnpWnTMWeRFAEb0QlNC36
         RFXl3mjE60KQfpqhcB3DMx22xVzHLiDjvAS8wv/SQYjGFsc1cNmxhrbYNTRo2iVxl1OV
         CNQBAIj9cxD1Hw9nnEPV7TTyLPOZTdnuiFWsXvDaMVTE4d7cP0fxR/Kotxa3rRAyQbsY
         U67w==
X-Gm-Message-State: AOAM5327mrBS596kYo7u8EnLu/aDtCnIYSLTsTUiSC4vC2K6G3Vj5Gpv
        IezcR+98HdXskESYHbydBIorBYs7
X-Google-Smtp-Source: ABdhPJxn/ZJEs7vfFKQ7aL8nxMwnlZnnnZIddiBbDX4llSYqkBxH//mjipcmFRVuaysg4B9LLRZZXw==
X-Received: by 2002:a1c:7405:: with SMTP id p5mr5330073wmc.130.1596676139379;
        Wed, 05 Aug 2020 18:08:59 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2803:3684:5e52:5417? ([2601:647:4802:9070:2803:3684:5e52:5417])
        by smtp.gmail.com with ESMTPSA id h7sm4661124wmf.43.2020.08.05.18.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 18:08:58 -0700 (PDT)
Subject: Re: [PATCH] nvmet: fix opps in nvmet_execute_passthru_cmd()
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org
Cc:     hch@lst.de
References: <20200806000804.6345-1-chaitanya.kulkarni@wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4c0eab62-d29a-f1d9-7856-78af8d6fcf48@grimberg.me>
Date:   Wed, 5 Aug 2020 18:08:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806000804.6345-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> This patch adds a check in nvmet_execute_passthru_cmd() to prevent the
> following oops :-

Why LKML and not linux-nvme?
