Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2566A206C48
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 08:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389037AbgFXGVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 02:21:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28782 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388090AbgFXGVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592979706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C48Rlxjz3s2bpLiAzhYiEAvH82Yp8YGVubELaSeN8Pg=;
        b=UGje8u9QfzheDS9VtWYDC9DvD8kz7Zs6ZMJfQj2OvYKUHbMw46Sjc9cVwMRTjcOFqZTuFF
        pQf0OxA9HQTYUnzjCxckHRLaewaN01lHwoZYDPXB02GjpClkt+qIiLkGIDtgeLC0lI8/a1
        7TTbZGlCf6VynszlpcVV6tJ+jFZsveU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-IYV_CO7lP2SgkKj9wmwBFw-1; Wed, 24 Jun 2020 02:21:44 -0400
X-MC-Unique: IYV_CO7lP2SgkKj9wmwBFw-1
Received: by mail-wm1-f70.google.com with SMTP id v24so1893349wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C48Rlxjz3s2bpLiAzhYiEAvH82Yp8YGVubELaSeN8Pg=;
        b=iQRu3T4iXrkQZvOhkiFwli+dhl19aGKEAE2xNbogKORw4GxZgYyBtub6ErDx7p1OrM
         yIfOYfIOyyR2Y41HTNayC7XIR8bCWPfyVecas7RRuyB4yBOBSUwRrH7tr6hdgc54oMk/
         tAN0Y01uTX4Eba6YVXO6U21tdJmARJJht/01PZsl+5QgxH6/l1U3EyOQ5RQpHl/Xf2/S
         zwT+vMrlbGQbr2AKbcI1xjqsAazu3TQNoI/5xYfA3UiS7m1Jl60fUt6BKXxPQTv27pkq
         lqXEhTM9Dxr6x8pXrxwjxLmIBUO5VPWEI3/wDDV74OllxEvvsA0hRlEH4TCsd7ZADkzf
         82sQ==
X-Gm-Message-State: AOAM531gf5wNxdFLTh/Td4Hi+MLGaVlUNDdinBuUoNxgXT7XHrWpkItG
        YQnGNP1HaMlOTxf7WpnRQnargnvgWMVAcUNg6lNj0v4FYoDSSsiJBjIp4Ae4p9xd92RWGwkSHzW
        zmzaCxTinikukUFYmSra1K60o
X-Received: by 2002:a7b:cb98:: with SMTP id m24mr15268696wmi.98.1592979703739;
        Tue, 23 Jun 2020 23:21:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRAU2gwlNqxDRRrpybYnMbwiytF23tZXMxgIgM8yxFkpT3cgJWPq+jOHz3hg3ByDv4mtlB/Q==
X-Received: by 2002:a7b:cb98:: with SMTP id m24mr15268688wmi.98.1592979703545;
        Tue, 23 Jun 2020 23:21:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24f5:23b:4085:b879? ([2001:b07:6468:f312:24f5:23b:4085:b879])
        by smtp.gmail.com with ESMTPSA id t4sm400429wmf.4.2020.06.23.23.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 23:21:43 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] selftests: pidfd: do not use ksft_exit_skip after
 ksft_set_plan
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, keescook@chromium.org
References: <20200623001547.22255-1-pbonzini@redhat.com>
 <20200623001547.22255-5-pbonzini@redhat.com>
 <20200623204441.phngiwlj2idonpe6@wittgenstein>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9ddfac6e-473d-1856-3ab7-ff61ccf11ac6@redhat.com>
Date:   Wed, 24 Jun 2020 08:21:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200623204441.phngiwlj2idonpe6@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/20 22:44, Christian Brauner wrote:
>>  	ret = sys_pidfd_send_signal(pidfd, 0, NULL, 0);
>>  	if (ret < 0) {
>> -		if (errno == ENOSYS)
>> -			ksft_exit_skip(
>> +		if (errno == ENOSYS) {
>> +			ksft_test_result_skip(
>>  				"%s test: pidfd_send_signal() syscall not supported\n",
>>  				test_name);
> If pidfd_send_signal() is not supported, you're falling through and then
> you're reporting:
> 
> ok 5 # SKIP pidfd_send_signal check for support test: pidfd_send_signal() syscall not supported
> ok 6 pidfd_send_signal check for support test: pidfd_send_signal() syscall is supported. Tests can be executed

You're right, this needs a "return".

Paolo

