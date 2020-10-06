Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC61285108
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgJFRlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:41:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726197AbgJFRlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602006081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/NBwYPLORlbVcrvKPyGk/TLmMoRjEUUqSOuonzOzquE=;
        b=jOLgrTYM7elLAdHt+lO47AgWgZJluLSOkedmahPuFcwkv4p0SzrDXYGuHQ20Z3AA5nDFfd
        dTk+r7WBbEYGyi61JvUSiNnFTxhxNuH9VYQyuasf0J6VPnHz1enUUSt+EYjZpKWRMKKsDs
        E4J7gc9CCsh8jD5duFZaYihRBPTpLzw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-YAA8287ZN5uuzi85m16ceQ-1; Tue, 06 Oct 2020 13:41:18 -0400
X-MC-Unique: YAA8287ZN5uuzi85m16ceQ-1
Received: by mail-qt1-f199.google.com with SMTP id w3so9559308qtn.16
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 10:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/NBwYPLORlbVcrvKPyGk/TLmMoRjEUUqSOuonzOzquE=;
        b=ESeiUbHbLT26dylWCnoCXglRxHE7JVKNvCCFRIugL62P8D4lJ6YYtGJc9d0sjMpclX
         CrwoBFGpc8Ak16sYd/2x8Ov++jwcivnbm4cn14D181r9gn3JMIoM4lLciUwW8IaiJQB3
         031vakEANYSN0J1x6AEHnNfRFQZ+U9nt93JqNBhJoOQ94QAARTyFXZpPJbM8b9HzOSTi
         zIArl3P3gSIMTDV7CjuAjy9wQ0XtfmoFuT1q6QOsC6ZqZcOhmg3CGfHISbbK0PeWVnHo
         cj0bz5/XlXrHQVQganI9pRFK4s1xnlS4sVp8rkpd9NoDMLkA8BF2S/kSkuxwHfZ5Dy0z
         Q1bw==
X-Gm-Message-State: AOAM532lOvpCve2Uq9HJmvfevtaUOJTHg8Kg1hCIoQUlnSaz0g0tLd3W
        J5Z9L8HUfn8Wd4StbupANRbJQFgnCb6mSOT9A8l1954d0ZpMHkafugLqyyu/lEpp6Wt45c9IMvI
        PA77BP1LsvianDo39H8rGdVIe
X-Received: by 2002:a05:6214:11e4:: with SMTP id e4mr5307483qvu.61.1602006077760;
        Tue, 06 Oct 2020 10:41:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwC6rrp56pJXHOW9M6RqEWmLm8gFLjcXWx1QR+BnWTFNsu+NoKfwHWuyOTRiXvlpY57S0kp2w==
X-Received: by 2002:a05:6214:11e4:: with SMTP id e4mr5307457qvu.61.1602006077580;
        Tue, 06 Oct 2020 10:41:17 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k37sm1332044qta.27.2020.10.06.10.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 10:41:17 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] fpga: m10bmc-sec: expose max10 canceled keys in
 sysfs
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201003012412.16831-1-russell.h.weight@intel.com>
 <20201003012412.16831-5-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b069fd5d-de9f-8d20-e3fb-e4d737032fb3@redhat.com>
Date:   Tue, 6 Oct 2020 10:41:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201003012412.16831-5-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/2/20 6:24 PM, Russ Weight wrote:
> Extend the MAX10 BMC Security Engine driver to provide a
> handler to expose the canceled code signing key (CSK) bit
> vectors in sysfs. These use the standard bitmap list format
> (e.g. 1,2-6,9).
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>   - Replaced small function-creation macros for explicit function
>     declarations.
>   - Fixed get_csk_vector() function to properly apply the stride
>     variable in calls to m10bmc_raw_bulk_read()
>   - Added m10bmc_ prefix to functions in m10bmc_iops structure

Looks ok to me.

Reviewed-by: Tom Rix <trix@redhat.com>


