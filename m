Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4F8244E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 19:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgHNRoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 13:44:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36278 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgHNRoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:44:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id m8so4902030pfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fWFuYTJqC9rkuibyrHJcQDAS3jyBCGpQV/kBCTUIe94=;
        b=Bam3cFJ9q9JHu+Ivk5YE3ASSepK3pI5SnzDiZTt4+vY/NDDlc9mLigPiFYBVMXemM6
         6VQo3oP6Nm9MB3tGK7WP4ggOvgo7PZNCZ+BNLRDYJtbW8+mgow9p4r/w/N8XHlRBIiDT
         kmwqbNhV4Pswn/iVilnUR9e65qS0ZqLiBaFZJBdGAws6Oebnk8W7LHhLDDRmq1EuOwbp
         MPeB5ghNNSAZck++mEYZvplprrBn2ZdjYPmS5gz35c/FwdJtacd5qRuSktg/MMZO2xb1
         nHZ3ZBGGDOICEuNfJAOKhkeOzNM2/+/OFRKQ3z9DMnlBqK2S8SB3TW2Z0mhSjMufYDTK
         6i7w==
X-Gm-Message-State: AOAM532/7oLGuJktKboPRcJk+taJS5+0pKMGlj0R5hob0FOq+WEHcQ9K
        GeO2UcZxsMu83zNEe5us9GMbvKNSSY+ieg==
X-Google-Smtp-Source: ABdhPJyPZcRJpy5TouzY8bBa430UZwwaPvWb3BbW9kH1Ug1Asy+9ksUce8bOyKs1QFgTwKp/2yay3Q==
X-Received: by 2002:a65:538d:: with SMTP id x13mr2461766pgq.33.1597427053869;
        Fri, 14 Aug 2020 10:44:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f? ([2601:647:4802:9070:51f:3472:bc7:2f4f])
        by smtp.gmail.com with ESMTPSA id h24sm8778658pgi.85.2020.08.14.10.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 10:44:13 -0700 (PDT)
Subject: Re: [PATCH] nvme-pci: Use u32 for nvme_dev.q_depth and
 nvme_queue.q_depth
To:     John Garry <john.garry@huawei.com>, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de
Cc:     linux-nvme@lists.infradead.org, chaitanya.kulkarni@wdc.com,
        linux-kernel@vger.kernel.org
References: <1597419265-68122-1-git-send-email-john.garry@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fd418829-251e-9ef6-d121-98556df9300a@grimberg.me>
Date:   Fri, 14 Aug 2020 10:44:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597419265-68122-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

queued to nvme-5.9-rc
