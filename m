Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C252D5094
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 03:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbgLJCBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 21:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbgLJCBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 21:01:19 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A86C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 18:00:33 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id g18so2743628pgk.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 18:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BVUMPlyBbapoY52I2KiTwKYlEKRNfNyqjjB2UXokEPU=;
        b=XT693OhxvozLtzPsM5QT2Weqy+FZ+Lz6BnDhalNPc+Gmfaa+wSQ3kj8dHT7ppw85Gn
         XXtWwoUHHsRcVTudcoFuNFFiHc493RiA8wLq7rBEugEQniVbRlaJ3GEliOUBDmoM+R2w
         2WHYhpVpM4sguooKe8PUqDcHYuJ4ez4E32bBhMsW5i6I2PTJ6R8xBZKODCk9YzknE4mD
         ydEKYdpdEG6+w9Ndy2IyUqy4K0ASyCkpmzvl4AfyncOWeQmaTRERukQB/D/m/ztHqM4/
         EPHcQ2dayRFGY5iFqxzVhR52wENrwBX9FYp5mIA9HsZ4ss+ZhsZqLvZX7AVLe6oklqZ0
         bVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BVUMPlyBbapoY52I2KiTwKYlEKRNfNyqjjB2UXokEPU=;
        b=YcMyFgQTQEBOpzOfGMeo03km2KUIJ1BIAMK/xitHImm+mzHkCtVYdJjqys9tU16OR4
         4QMCJkPgtlTFng4In+M/3O91PA1QlqlEam/fNyZki+U0aZQO4g4ExuQipV7f6thcJepd
         wmHQkxgaVlrGq+pA/cEWVmtiibKtlxxpkDNjMiuTqh2A8tD7/yZoX2e18i6LFugbsVQV
         EYjD6tPLelyTa5BOJx7hgvb1KAPe7fKI77g+dkULpYbdSJpSb99s/aXV3VcY2iL4ns+V
         dvqWFCtHiwxxS595afVx26cqXtQ960zkVg6WzlX/SRMxAKMOfCIHr44ssaQiYANjVR8z
         AZDQ==
X-Gm-Message-State: AOAM531N2vZ7QrLbt6m8uqIRzFDhHr3Yzid4ig3gwQNchbsT/qhNv0o+
        HT7RbkgWHGU3VCIz1NomG6k=
X-Google-Smtp-Source: ABdhPJx00f633nK+qysghi0WUdNTia8Xb6q3VMy+pVl2keYUTS6mAJ/RyPNLgJDRFvGtxwYeKiGG4Q==
X-Received: by 2002:a65:4582:: with SMTP id o2mr4525121pgq.97.1607565632732;
        Wed, 09 Dec 2020 18:00:32 -0800 (PST)
Received: from [192.168.0.104] ([49.207.210.144])
        by smtp.gmail.com with ESMTPSA id y69sm4021999pfb.64.2020.12.09.18.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 18:00:31 -0800 (PST)
Subject: Re: [f2fs-dev] [PATCH] fs: f2fs: fix potential shift-out-of-bounds
 error in sanity_check_raw_super()
To:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>
Cc:     syzbot+ca9a785f8ac472085994@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20201209181322.27932-1-anant.thazhemadam@gmail.com>
 <9e38608c-9fc3-1f94-d275-742facef3db3@huawei.com>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <8d293b99-4414-1317-7426-79692bbaa715@gmail.com>
Date:   Thu, 10 Dec 2020 07:30:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9e38608c-9fc3-1f94-d275-742facef3db3@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/12/20 7:16 am, Chao Yu wrote:
> Hi Anant,
>
> I've posted a patch a little earlier. :P
>
> https://lore.kernel.org/linux-f2fs-devel/20201209084936.31711-1-yuchao0@huawei.com/T/#u
>
Ah well, that's alright, especially considering that your patch looks better.
Glad that bug has been fixed nonetheless. :)

Cheers,
Anant
