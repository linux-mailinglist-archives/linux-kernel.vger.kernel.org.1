Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D122288AE1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388762AbgJIOaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388727AbgJIOaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:30:12 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D450DC0613D5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 07:30:11 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id z6so10765897qkz.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p7Tcy41BHHzdJD3d55Dx7+SitKAuIMpz6nsj1EKscQ4=;
        b=PXQzFPw+2zyeumJOQcaBO0MUOi3o+J7O34smVyrogzNMl+qwUVlv5JD9mWKrvmZqx4
         6O7hY5mXBCBp+JMuIOs0AUUI09cw+F3mZozuQ0HA2oTZPmn3WvFLzbrESeUi1QSpktvV
         RZ2izTI0vG7QKJL+vybdmyFBujHf4DfJCRCGwevYFXywyJQpuW4gjJieQ1pLzC5YUuRR
         j1u5XwQgtC36/uSpcjUkBu+f3KtSUHs7owqqAWhfPtrTIBV8fDqGyP0W58Y3Ca/6iOWh
         DWOEfokxeQXQX21QxYgUi7Eiamh8Lw/QDbwNINXKHJikr2ILcLmGc4FAQcqHwWBqclof
         3izA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p7Tcy41BHHzdJD3d55Dx7+SitKAuIMpz6nsj1EKscQ4=;
        b=Z6KnRqF8BuTaLvGFO3sIp1Z+Nwvh8oUh1GLQN7kSP11SP6kY+2EWpnEpxPdghyjxza
         KiilNgfk7fFnVZ4iLJcnUeHjmP6sW5B6uohKx3OSEKGJGkSrwq9YRQ5iug1rVT5cMJ+4
         F7lP6dYz2HZ6lsHeNJX7+OtKipl8+rkUUCpi++7r5ZRllgrAlq05o32OPIEOGueac3F9
         ornrXg9HTF/agLwoXzk0uNO5ncyTgAS516wDj9YL4X7fI2Iac2/0EpDsbSr8gcv//eGR
         OGzPV18F4o0zvxRTo4++AmGPkWgeOCEbEsV5bG190+J5vpGty7UozQVphQalTUK8cyxC
         oRpw==
X-Gm-Message-State: AOAM530XkBfUQxRUD7RFeCL/NGt4Ji5cMa0p5ONP9inPwWnlv4rpl+8o
        /n9l1K0mwxoP+AA3AcaN9Uj/npqRee0Dlg==
X-Google-Smtp-Source: ABdhPJykdSDHPibSC9hA2ZTSLVymx8cWxLJ7r95HtK9LpRSGM3JYCE24+QKVrBoWD/AJwUNdKPcMUw==
X-Received: by 2002:a05:620a:128c:: with SMTP id w12mr14124460qki.355.1602253810703;
        Fri, 09 Oct 2020 07:30:10 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e8::107d? ([2620:10d:c091:480::1:f1f8])
        by smtp.gmail.com with ESMTPSA id x25sm6278777qtp.64.2020.10.09.07.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 07:30:09 -0700 (PDT)
Subject: Re: [PATCH] btrfs: ref-verify: Fix memleak in add_extent_data_ref
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200827074339.22950-1-dinghao.liu@zju.edu.cn>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f13c740e-b140-9dbc-04f2-0142de59f099@toxicpanda.com>
Date:   Fri, 9 Oct 2020 10:30:08 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200827074339.22950-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/20 3:43 AM, Dinghao Liu wrote:
> When lookup_root_entry() fails, ref should be freed
> just like when insert_ref_entry() fails.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
