Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084FF1DBA69
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 19:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgETRAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 13:00:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30340 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726510AbgETRAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589994010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X0s/clL5mjNTm9iTq4AW82jUcL/vW7HiRSQKjdhr2yY=;
        b=Mj9eUXZ3OJMRcFmQRM4bJmVlX29A1AmAEqaeJQyCQL9dQtmgMRS70fzNEbovWRE73Lcvfw
        tLj0zzP1usjEElwqPbpDQACvJ12OPdkd+8kteO13PoOSrpKOeNJHZDMPo2ZwMH/NYNFdl6
        juJWQ/WgDfLeTtIc2EjKry5HQ6SLtPY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-aNX38VWkNhyODuYanSepIg-1; Wed, 20 May 2020 13:00:06 -0400
X-MC-Unique: aNX38VWkNhyODuYanSepIg-1
Received: by mail-wm1-f71.google.com with SMTP id g10so1513281wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 10:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X0s/clL5mjNTm9iTq4AW82jUcL/vW7HiRSQKjdhr2yY=;
        b=pe6X2AnvOZHuVVJfZAzdhLs1sbHX3xq/hvZj//mhzhSnryZiV28/5EVgMpL+jwVaSW
         Q/HWSNr60cKI+nx1gJpMLke5isNWt+XlzP+wqYRjRdb0V/oD0kqVsPCje5TNk34WUI+4
         HpO+GE2LCF6GzKoVzfIbINM8fSZ/D28gfuvB47Y52BZWmbAbiK3np5ca/ax0Tc8qEu4n
         kncAfwO4ZhBNXaaJQaxI8leSl9bPyHf6/2e8rE6xkZ6+iNJgOY2mCI5s2RSbuxi3Pl0z
         HeeLm+FXoAr/R6EeIZg3uzZczNofEbflMwVO1uocoEKIwMZBpQK/asd8x8OO4gs3KxQk
         aeAw==
X-Gm-Message-State: AOAM533bGMnN2yceyO7/7W1PCfkJPsF2zk1NQNBBvE9WadcxIMUZp/aI
        XKWfHblKGcfIQd2vdpNZw1o3xRMnd7TVgAX6vdiQVGUI3oRVSV/OjZqowJipdy/uegQG5ti9R+M
        A0eDewgd1x8kaxW/1G8s6rNZY
X-Received: by 2002:adf:f5c1:: with SMTP id k1mr4893038wrp.30.1589994005496;
        Wed, 20 May 2020 10:00:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuFBue81XLEPWPGpg5C2PeSU5lxiWQNLEInF0QLqbrJcCGW+wbuSIRM+Mf8XQ0LvrbqxtoWg==
X-Received: by 2002:adf:f5c1:: with SMTP id k1mr4893027wrp.30.1589994005256;
        Wed, 20 May 2020 10:00:05 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
        by smtp.gmail.com with ESMTPSA id v131sm3947123wmb.27.2020.05.20.10.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 10:00:04 -0700 (PDT)
Subject: Re: [PATCH 1/3] selftests: kvm: add a SVM version of state-test
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     oupton@google.com
References: <20200519180740.89884-1-pbonzini@redhat.com>
 <87y2pmsg8w.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <229dd02b-d8ab-0a81-63b5-0d24061ffe05@redhat.com>
Date:   Wed, 20 May 2020 19:00:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87y2pmsg8w.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/20 18:50, Vitaly Kuznetsov wrote:
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 

This was sent by mistake, but thanks for the review anyway!

Paolo

