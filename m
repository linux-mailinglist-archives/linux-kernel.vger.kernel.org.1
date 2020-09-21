Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9336B273587
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 00:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgIUWOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 18:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIUWO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 18:14:29 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B9FC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 15:08:40 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id h17so13844525otr.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 15:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=JGUMSDUiuFrAeiPpx9FqOcOPewDwKw2S1qq1Uii+oBE=;
        b=Mf84vIYi1/cUdHiIBkoIbDq6bN2+2B0d/lYeNMFAeNJpeppdheNZPNqkOcZwn74RTL
         fNQFYmz7+oyN4lwaMOaJrNJtz+ydxJrB5s4Unw4F3Xe5H3xB8qGpD70Ce1p5Oq4wnGpg
         CJc8tFLvuWiEtAe2R1NukNJqCk0jM+iIG0DYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=JGUMSDUiuFrAeiPpx9FqOcOPewDwKw2S1qq1Uii+oBE=;
        b=QN5OpP91eHERo9+1F/zzyixEBdcMJ5CYr5bPvCUQiHZ6NxnThZo6pRpwqqPlSpNaNU
         gNUAzcyQHRY1iEI4LCPwfGQVMQmjhwJedd+hyrvSiURqPmI8INUCn1ZQWI+MZHcihlPx
         WfHvvhoW7SHq+WVdBqBGmGTIgAgT2mYuMslfNFKyzU7TL0NWLH4Cr9RQY166hX37p/Y7
         TkLJZFRWMPI8oG/TW+6R2XhDJfd5ka7bIQpCeyJXj+bhpx7UvmHnahlv1TK6dOqK9ThP
         lZdw2Yw960Ao96aALlqIsqBJn2PEPz8DiiII1Q2Dx+dDDm8wu5rvB8djjZjWLJZ+HtBI
         InGg==
X-Gm-Message-State: AOAM530yYZte0Uxgf1JGbGSuTpwyM4A/3UCcjDcaJnmDK8se+q2j8i4n
        idfKAWEETSnkZTMi0EhKvlU51Q==
X-Google-Smtp-Source: ABdhPJxcJJnmaRYS8s9zUSRJadF6CYSn2qaBU1sneIivpTqGdSksjT4CsxwqGkGwGRl+O2/nQ3EdQg==
X-Received: by 2002:a05:6830:4f:: with SMTP id d15mr1015843otp.7.1600726119284;
        Mon, 21 Sep 2020 15:08:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s196sm6948293oih.26.2020.09.21.15.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 15:08:38 -0700 (PDT)
To:     oded.gabbay@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        obitton@habana.ai, lee.jones@linaro.org, oshpigelman@habana.ai
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: drivers/misc/habanalabs: atomic_t api usage inconsistencies
Message-ID: <3dfdda44-3564-1775-c844-f7a2680c9c58@linuxfoundation.org>
Date:   Mon, 21 Sep 2020 16:08:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All,

While I was looking at the atomic_t api usages for an unrelated issue,
I noticed free_slots_cnt in struct hl_cq incerment/decrement/reads are
not consistent.

atomic_inc() and atomic_set() are used, however instead of atomic_read()
the value is referenced directly in
drivers/misc/habanalabs/common/hw_queue.c

hl_queue_add_ptr()
atomic_t *free_slots = &hdev->completion_queue[q->cq_id].free_slots_cnt;

hl_hw_queue_schedule_cs()

atomic_t *free_slots = &hdev->completion_queue[i].free_slots_cnt;

Any reason why this is necessary. I don't know that this is causing
any problems, it is just odd that access is inconsistent.

thanks,
-- Shuah
