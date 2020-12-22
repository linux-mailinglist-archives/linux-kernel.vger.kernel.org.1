Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727502E0CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 16:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgLVPv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 10:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgLVPv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 10:51:57 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10855C0613D3;
        Tue, 22 Dec 2020 07:51:17 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id d8so12286396otq.6;
        Tue, 22 Dec 2020 07:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sbjwQD9yPLDEKc5szkM9/K42vca05z6mwB/Aln6neiw=;
        b=QoH5QKtaAOyuLjYe5zaP/xk9qq08eQ3EO7L3l8MdQKAVgD55q4/RCnzbSw55so9ake
         7yu1ldwenD+XJruPKAwVizDtHAfwPDyFd6zkVr15bU3kQ8onFPvH4Y/DcqrbwETfwls5
         Gf9xEGYiKoLU/Lij8grFQBIyd0V6h8uQRHA3rSd08fcgU9Uu7XKb6NS+5gyDDhRmLSUH
         tMIK07cWsv4cJrSecgteP9fFWLuoeWhB3VuCvzdMUuYOOHmJsDJy8gdhC0rSQtxTGokR
         5geeXyDbKvrZLWXIhDtbYc1D9iQOIF6necsN9ocomt6+jvZiglbCaIYByUPfyMtbnhOE
         glNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sbjwQD9yPLDEKc5szkM9/K42vca05z6mwB/Aln6neiw=;
        b=dODyqQJjRB1R6w8CM7Hh7sw0/YT5awk57oGvxTAIX4nGae9l/nnwUkMMu0Yn8Z+vVN
         fCw0mj2kQDmkbxLYCBBvkRSYy6DsUkMhjTS8xcHDCP8Tr1EpEbEfGvAYlOhUDIIu/Ez7
         J79HNXz2EkLQL1/R8oEzld2GJdjKMBxafVWDG7XjQLfY8zuh13dWPmSREY9p7WLVrVR7
         IFplIqjOC3KWsz2jC3e8lHreJiemibRMyaa8QOgiZo+URUAzYjnjX0GKaWOqfxk8shM2
         VKOG6OFLLk11C/IGWvALNDT+8MLGhXXpMcHvLk1Uki+lZ5srwzZsXDQ6C5cpSEXeqjuz
         nhfw==
X-Gm-Message-State: AOAM530W2xyIF62ryNJdREZXeqdVbeJ353TjomhY9VMYs4uR5/Urh+q/
        3ft8YtPGBXqEEqVlF57xRH/T3WKURqM=
X-Google-Smtp-Source: ABdhPJwqT0XraSTX9qGWcmnWNGVWceqekUlTl/bJbr26l0KpcaoZ5af4br47aQVkykCM6/r5K5NSbA==
X-Received: by 2002:a9d:6208:: with SMTP id g8mr16444301otj.165.1608652276344;
        Tue, 22 Dec 2020 07:51:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m29sm4502114oof.20.2020.12.22.07.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Dec 2020 07:51:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: k10temp: ZEN3 readings are broken
To:     Gabriel C <nix.or.die@googlemail.com>
Cc:     linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Wei Huang <wei.huang2@amd.com>
References: <CAEJqkgiiU7miC13iT6DufjFAsHkNZk6rBAw=KRRnHe47kTZDnw@mail.gmail.com>
 <9d621d34-e5ce-301a-1b89-92c0791fe348@roeck-us.net>
 <CAEJqkgjFVBEDxCVB+P3CjirRkCZW1_6s18AgOKpe+6er3VShpA@mail.gmail.com>
 <20201222061630.GB76917@roeck-us.net>
 <CAEJqkggMJMKS5E2n26nvoCfq1tnokQG+WQi+WH4J7gNNz+0o5A@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <5d8a2b4b-dfa0-d8c3-e827-0dc9971caa0b@roeck-us.net>
Date:   Tue, 22 Dec 2020 07:51:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEJqkggMJMKS5E2n26nvoCfq1tnokQG+WQi+WH4J7gNNz+0o5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/20 7:26 AM, Gabriel C wrote:
> Am Di., 22. Dez. 2020 um 07:16 Uhr schrieb Guenter Roeck <linux@roeck-us.net>:
>>
>> On Tue, Dec 22, 2020 at 05:33:17AM +0100, Gabriel C wrote:
>> [ ... ]
>>> At least is what the weird amd_energy driver added and since is only supporting
>>> fam 17h model 0x31 which is TR 3000 & SP3 Rome, I guess fam 19h 0x1 is
>>> TR/SP3 ZEN3.
>>
>> The limited model support is because people nowadays are not willing to
>> accept that reported values may not always be perfect ... and the reported
>> energy for non-server parts is known to be not always perfect. Kind of an
>> odd situation: If we support non-server parts, we have people complain
>> that values are not perfect. If we only support server parts, we have
>> people complain that only server parts are supported. For us, that is
>> a lose-lose situation. I used to think that is is better to report
>> _something_, but the (sometimes loud) complaints about lack of perfection
>> teached me a lesson. So now my reaction is to drop support if I get
>> complaints about lack of perfection.
>>
> 
> I agree it is an odd situation with these modules, but having
> something is better than nothing.

That is your opinion, and it used to be mine as well. As I said, I have
learned from the feedback.

> As for the amd_energy driver, yes it is off on some platforms by 2%-5%
> or alike but without having
> that support in the kernel, regardless of the module, we cannot ever
> come to perfection or near it.
> 
> For both k10temp & amd_energy driver I suggest to not drop the support
>  but add kernel modules
> options disabled by default, much like a lot laptop platform drivers
> have for different reasons.
> 

That would just add complexity for little gain. The code would still have
to be maintained, and as experience (and the out-of-tree driver) has shown
this is a never ending story. Plus, it would still be inaccurate, leading
to complaints, module parameter or not.

> The amd_energy driver could have some any_ryzen option which turned
> off by default.
> That way people may decide if they want to use it even when not 100%
> perfect and can report
> back on platforms the reporting is accurate.
> Waiting for AMD to give us ID of what may be in their eyes accurate is
> like waiting for pigs to fly.
> 
> The k10temp module much like the same, some experimental_voltage_report module
> option will be fine for now, I think.
> 
> I'm also sure owner of AMD HW will help out optimizing and maintaining the code.
> 

Not really. My experience is that almost everyone will just complain.
It was a bad idea to add voltage/current reporting to the k10temp driver,
and it is time to revert it. If someone else wants to write (and maintain)
a separate amd_voltage or similar driver, I am all open to accept it.

Note that even you suggested to _drop_ the amd energy driver instead of
fixing it. I'll take that as a qed.

Guenter
