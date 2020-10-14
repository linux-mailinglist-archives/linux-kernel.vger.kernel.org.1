Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D2A28E6D6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgJNTAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:00:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42246 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgJNTAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:00:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id x13so349157pfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 12:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wLaTKq22Xjuu2qg4q0rGmB+fJwf3TTouQqQmSiOXGWs=;
        b=tjuG6M5RJ6ICdqIwzVOf7Q6wT6z+uJCXJDl6qdk+3k2VMXIcHI6HI+XDo2TpVpeEK9
         lZHOI5PZbTOo5fNE6nhYjh8quVz0fmAl4LWm98sAVQUyZ3swLs/+Yj/+ccWQCpwkoHK3
         sPCMEEac6lN/5Ce5tjtkdxSGIeMZT9QogBsj/CzE8q0FQDcG/9oMwMVMkPvaIc15NBY0
         fINSoMhNgGnVS+WBfa8T10lpOKksAHQ//MDgXJyV4bLjVtO8IMpRyU+A2j+EEh4WDHib
         yyUFuXOdbDAwON2iYm3rd8OgRhpiwZgxxjdmp8eiAjHLgiPDvgoOsiEHZMF47+FgLHD1
         x/fg==
X-Gm-Message-State: AOAM532OtEsGwKyXiH8BUs3qph2CN97oPJyY8m218TbZNC6w0qGj79Oz
        SPBEcAjwiDe8JjNa8obuUbI=
X-Google-Smtp-Source: ABdhPJytz7RA9rGz/EMS5FD6O05JsFeMUv6tOrug+4pY+8qLp7HZuxvhl0dfqbzOSvBznRhpzM7tqA==
X-Received: by 2002:a62:e112:0:b029:152:b36e:b05d with SMTP id q18-20020a62e1120000b0290152b36eb05dmr661467pfh.3.1602702038655;
        Wed, 14 Oct 2020 12:00:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:7f9a:6575:dc66:60d9? ([2601:647:4802:9070:7f9a:6575:dc66:60d9])
        by smtp.gmail.com with ESMTPSA id 78sm323384pfz.211.2020.10.14.12.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 12:00:37 -0700 (PDT)
Subject: Re: [PATCH v2] nvmet: fix uninitialized work for zero kato
To:     Keith Busch <kbusch@kernel.org>,
        zhenwei pi <pizhenwei@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de, chaitanya.kulkarni@wdc.com
References: <20201014033650.953656-1-pizhenwei@bytedance.com>
 <20201014161048.GA1267726@dhcp-10-100-145-180.wdl.wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <517a0b11-5bd0-4d8e-da0e-e0e0a4109897@grimberg.me>
Date:   Wed, 14 Oct 2020 12:00:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014161048.GA1267726@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Fixes:
>> Don't run keep alive work with zero kato.
> 
> "Fixes" tags need to have a git commit id followed by the commit
> subject. I can't find any commit with that subject, though.

Fixes: 0d3b6a8d213a ("nvmet: Disable keep-alive timer when kato is 
cleared to 0h")
