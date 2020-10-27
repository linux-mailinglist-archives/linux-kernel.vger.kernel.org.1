Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AD529BF91
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1815579AbgJ0RDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:03:21 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:36847 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1793627AbgJ0PHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:07:32 -0400
Received: by mail-ej1-f53.google.com with SMTP id w27so2728005ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 08:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HMdPNjwSLozyzn3RftSfCQhC1Kc6w/BA0EH6kn1tXI0=;
        b=PcQp+41aeI1vH+B2LNA2fsiDnTuXMbxyh7UNIwHqq/T+dni2pgbZWU7aNLEUq7L5J6
         1Fm/jtBSTsvi5Ino+7h7+L6LG0Z+G3jlcgI32YYrglVcAGOFXSgtNnJf3n8AlHjDjC6D
         6OIQtTWgOyReDdZyDiW1ATAJJlKFQRl3+O/n2dPkBu3aagV6zTEs0kfMJapFRFJ8B5O2
         BQLxQNHMc5hZtCEqoDXQAAVtxhgA1heJll09eQ2C4QK7zEucvykiLnbDoX6R+pjLjozf
         s1mT7i7NvXnvJE0Tt936QJMUx872Ct6kH+dQ1oFmG2X91LHxpeX4uZ4B7GhmVIU2ct5o
         Xa7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HMdPNjwSLozyzn3RftSfCQhC1Kc6w/BA0EH6kn1tXI0=;
        b=g9G8bAl/ruBENBiQ2XwW1fVE/jYPYgitCL3YPYkqmJmOGYPHJIaxud4qurvr29yOwX
         VYMq1dUvecLGZsjDjJUIuOaS19lh71H8Hl2aIfY0DiEwz1MpD9pyaTrUGwXlCa+WjvjJ
         DPCbzEy0zd4ee9bAyC9TbpgOusb9atFMZOV2j6EBzUMeKNFVqWfzfJw34thOfgoi9g0S
         xQBUPYd4BU/p4foVCpESl+Mf/p5Mgs6muMvnqtzRJ1sDFT8EbCjF7W/5IV5Vl1pu6jpX
         KtF45TZQgqj/oz7R8vwMvykegvrbO3GTeMz67SCTP0+wDZ/qNuCcqODd/xR0PJrtyf4D
         k5Bw==
X-Gm-Message-State: AOAM533YbL23fb+guyc3Y9XD0tOXorlkO/hsoqHkxhf2sTEcFe7teF4z
        ppWI4gAQMCSikfDE0Hd3f2ITuQ==
X-Google-Smtp-Source: ABdhPJw0DHH6pKepxG03xzCuJu9j2wLkQzCavaOiEl90/5K0OgUEwX5sGoWb02fqo5uRZ3mVpHN33w==
X-Received: by 2002:a17:906:c293:: with SMTP id r19mr2729105ejz.63.1603811249476;
        Tue, 27 Oct 2020 08:07:29 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:567:3dba:e4e9:3d61])
        by smtp.gmail.com with ESMTPSA id u6sm1157623edy.16.2020.10.27.08.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 08:07:28 -0700 (PDT)
Subject: Re: [MPTCP] [selftests] f2ff7f11f9: WARNING:suspicious_RCU_usage
To:     kernel test robot <lkp@intel.com>,
        Geliang Tang <geliangtang@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, mptcp@lists.01.org,
        lkp@lists.01.org
References: <20201027131624.GO31092@shao2-debian>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <c971b9f8-fd4a-292f-a7d8-8f6ef43c347e@tessares.net>
Date:   Tue, 27 Oct 2020 16:07:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201027131624.GO31092@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 27/10/2020 14:16, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: f2ff7f11f9a74842245db52d685bf9bc7ac2c4b1 ("selftests: mptcp: add ADD_ADDR IPv6 test cases")
> https://github.com/multipath-tcp/mptcp_net-next.git export

Thanks for the maintainer of the kernel test robot at Intel for this bug 
report!

FYI, this was already reported earlier:

   https://github.com/multipath-tcp/mptcp_net-next/issues/102

And Geliang is working on a fix (a v2 is available).

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
