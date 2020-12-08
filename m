Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAF42D245C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 08:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgLHHaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 02:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLHHaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 02:30:25 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD35C061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 23:29:44 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w4so11382574pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 23:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8h/OBn5YsQcazbH0YJ7H9JhJyr0LzcHAvsUeLZrYXoE=;
        b=T2KoDWfMFaB/av8cF5B2b6YMAcRuVuayrd/BdqYJmDPpYtuAKyMEU1A8+TujtnGIzC
         EaHKGHFRkF4oGVPxKfhhuqj4LET5hI81E07bSCr1VWNRFtGRZ1QV+r7dPUAo6zt5Cfx7
         qrU3eGjTcE9fR+Re1/Qw9S9OpwUPk9ykolygbkRTbq73HLtjNoXs3ViewCJbYDZv85SA
         sI8qJInQiX/fdndM/MQW7ORzzY6Bel4EUI0gyefHSbC7TqC3Nqt6zJLMbbhmbkHGm3Sk
         qCAqVR/9ikOCHJ2mQ5p7BHNkzt0ZAB+fiNQfFZw6jG0uMpIbP1KXbikOx+p4/JEA/Cht
         +Wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8h/OBn5YsQcazbH0YJ7H9JhJyr0LzcHAvsUeLZrYXoE=;
        b=TOLnFf319+nEVsHaAdCP2slVxtRY2iZhZ4rPbZjbjJJnwJQHI1hr3zXpPB7j/yHgx4
         Yt5TLBnW914sUyZHHTa3geCxvbmE9xCG82JnrQi9PCz5BUJ34huj9wqX4UbiP9nHp4O2
         29KcFv0NfBJXO+FIFEBMenmiQrWdXUz8CTBvHu7KKtZIsq3xoGQXeVUVySrYNCnlOQLV
         6uuKcuxjOECCsjxKs32d6o44SwzTsPjqxV/Dsjga88HQ2zTCXLhj/aocsP02KbmBlqLk
         uoTmJ35vzS6yQDtjkQnLlzr3xhadX2NVonPll1pufTQWfBqSS672MKsGTpwBjYb4WDTU
         lF5w==
X-Gm-Message-State: AOAM5327EozhlNUTWXQuckDlc2KdL6L0ToHd2FUENCrugBiSxOJQEjBH
        rN/kv35TX9jK6IT7pJjeuIAB6w==
X-Google-Smtp-Source: ABdhPJwCFWtVmJZShx+XTTI521TezRb3o93j0vtSG0nISjwgARpJMC0+38h8keb+qMeJO407Qdo7ow==
X-Received: by 2002:a63:2253:: with SMTP id t19mr21823988pgm.400.1607412584477;
        Mon, 07 Dec 2020 23:29:44 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id d203sm442940pfd.148.2020.12.07.23.29.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 23:29:43 -0800 (PST)
Date:   Tue, 8 Dec 2020 12:59:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Shuosheng Huang <huangshuosheng@allwinnertech.com>
Cc:     tiny.windzz@gmail.com, rjw@rjwysocki.net, mripard@kernel.org,
        wens@csie.org, jernej.skrabec@siol.net, samuel@sholland.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] cpufreq: sun50i: add efuse_xlate to get efuse
 version.
Message-ID: <20201208072941.7xbqbolo6mct6niz@vireshk-i7>
References: <20201208071928.2078-1-huangshuosheng@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208071928.2078-1-huangshuosheng@allwinnertech.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please use --thread=shallow while creating the patches, I use the following
options normally, so they appear as a thread.

git format-patch -C -M --thread=shallow

-- 
viresh
