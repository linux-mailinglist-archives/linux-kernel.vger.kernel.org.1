Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7D629E06B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgJ1WE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgJ1WBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:01:43 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553E5C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:01:42 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id r127so701307lff.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZSGuSpVbrYXqvQX8npzSAPk+CUf9VoIWenmBS9/323g=;
        b=miAA0EpDbvmPE1sBZhDoCst5oKsnJ0kuLn2t6x7sG82IwM/Phko6ViXKjJoPI/iKjf
         bU5PganRsQ9JQnYk/PWsU7DAXWAbRk38Z17IP/FeAb6koWwxbwGHbUXWb1JUEVYmVYY+
         NgmtQMoaz5KzDRATjBXDM6Aio05EM3dXEBf6Xo3GwffuwcnC7zMdaz8d+C7B7rqcPlTt
         Z5rXMKeW5QKsGg6hl15M2bOdM155ztuhtDMBuXV7rYnUWfTFgK1Q6WOwzequniJVYcl6
         1pTF9i2RhtVTbdba+rqDXOXEC7xOpCKLBYG5w30G02dThWTe/AwYM0Pf/aO5dPCkylfL
         q71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZSGuSpVbrYXqvQX8npzSAPk+CUf9VoIWenmBS9/323g=;
        b=Qw0WJjdg8wuGux66bDzM0p/iT2PKUlCC/neIzJq5317asphIm69vipJVXYFcT6UTaa
         v0TQMWRpn81427eGCzfvpZMLGkA+rEgZDaYAJ+55xpPIs377aZ+8FRvnx2sa77RrFoB5
         8U3HKl2k+OmoVoZTZlI0lAqLVZHmiVMDuxarHdccsh1RzZ4yzOLY91SgO8AhCI02SHPz
         KqttGdZXViAa8iHOEQd5KeIq9ONkRCBi/bsWBSjcINlissb03b4jVF9A2z7z20GLOdWW
         EPkkLEDXf4QKd33GLC2AeXi0a2Fp6jc3jcM/W96SWXIkLjSyc31X21MvF0sJd4lwTE9S
         jdXQ==
X-Gm-Message-State: AOAM5315U950IfRe3NrCMwkJvfECL19BMrBCHM48VAw9ZhDpKz3LkHmo
        iX5AiTst9JocL3KVxblgvJhNLMrWC8PGa+sw
X-Google-Smtp-Source: ABdhPJwqftN4TrrF2KE85kAkIeYXG86bR3fgJxlSlQlzBaI4mt986iMR18W0B6JQ27gOTIgxuoLH4w==
X-Received: by 2002:a17:907:20d6:: with SMTP id qq22mr523095ejb.187.1603912122598;
        Wed, 28 Oct 2020 12:08:42 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:b5f:62be:7509:9de4])
        by smtp.gmail.com with ESMTPSA id rl1sm249492ejb.36.2020.10.28.12.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 12:08:41 -0700 (PDT)
Subject: Re: [MPTCP] Re: [selftests] f2ff7f11f9: WARNING:suspicious_RCU_usage
To:     Philip Li <philip.li@intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Geliang Tang <geliangtang@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, mptcp@lists.01.org,
        lkp@lists.01.org
References: <20201027131624.GO31092@shao2-debian>
 <c971b9f8-fd4a-292f-a7d8-8f6ef43c347e@tessares.net>
 <20201027230039.GA25647@intel.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <063c2289-1779-1c33-33f1-cfc186e9d9e1@tessares.net>
Date:   Wed, 28 Oct 2020 20:08:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201027230039.GA25647@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philip,

On 28/10/2020 00:00, Philip Li wrote:
> On Tue, Oct 27, 2020 at 04:07:28PM +0100, Matthieu Baerts wrote:
>> FYI, this was already reported earlier:
>>
>>    https://github.com/multipath-tcp/mptcp_net-next/issues/102
> Thanks for the info, we didn't notice this. We will take a look
> of reported issues in future to avoid duplicated report.

Thanks but I also hope we would not have a lot of other similar issues :)
In this case, duplicated report is not a big deal!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
