Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2FE2C1BE1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 04:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgKXDMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 22:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbgKXDMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 22:12:33 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3B8C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 19:12:33 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id 5so9938923plj.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 19:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cfq/nfp3VIzB8kJ/4Aoe3//TNwxiq0kRsB2O4wXa0RE=;
        b=IXunGBT9lpxE1Gy8krkmLoqv/tMttjxnyEzpn5GnDMS6x2sVRfT6iaM2mTyERBcwpO
         JGqN3fvtmVJLEcMLVtGbIy97fQ+C5/poj8rqzut2+zr418EkXROU00+uyjUUNbcRtUxX
         Jn+LquVXjlOau82ObZGD3hyah+OELI2ty5PB1IcscqJUcfyVzokfWifzPr64EZo0djvi
         Uk7tnsqigFBsVtAU4r+PexSBl+Eh5lZPosiUCOqGz18y9owFqD3s50AhovMrCx3ZoIPE
         m7MlZqWq4EMzbPR9X9XVjjQ03iNSFrm240qaK0m7ZQQ0DjbvWfs9EQIetii5VEwhwFwr
         lF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cfq/nfp3VIzB8kJ/4Aoe3//TNwxiq0kRsB2O4wXa0RE=;
        b=ssV/D4jdvLYW9P/b78NNdJnhLXgHMnVdeYMum4NHzCydvbeFfSlJotb8zh/Fge7nF/
         B2Ans86unWMu0q6J9PZmD8EAH2dzROx5sv8lecstRFZqc8BxhPC7fv8OED+riaB4bdLz
         k4gR/MbDS9tbN1lQBaceyifkDEA/9Rnklzhk3e/J/9/iivAYP85WA6aK5PmXYonhs638
         soCX41qYCfuLZDgodgnuo+vCL8Dm4nAtARc0W3g4R1ydBHZIOGXh63tj/lAo/04QbHIy
         bj2A+SF/tqIzAz5zDsL7YXHXoOB92chxMVOROErT0adqbRgZOZE1eDGlfpzpoMKNugxv
         M/XQ==
X-Gm-Message-State: AOAM533CIWH87A10IDScN1rhr9erT38rakrlRv0PPtLAotJPuCVEr/nO
        /aL3xOnPy0KaDvTx4nsvBJtqEBc0wHgobQ==
X-Google-Smtp-Source: ABdhPJy/SIbj27bYteQDbCYS+9HoSmJamtqkCHRqx4xz1b6nckV/I6uvO+e91XVibC7lu6fkFBdqZA==
X-Received: by 2002:a17:902:eaca:b029:d6:807e:95b8 with SMTP id p10-20020a170902eacab02900d6807e95b8mr2304073pld.33.1606187552480;
        Mon, 23 Nov 2020 19:12:32 -0800 (PST)
Received: from ?IPv6:2402:3a80:422:4fb2:189e:bfca:2836:414f? ([2402:3a80:422:4fb2:189e:bfca:2836:414f])
        by smtp.gmail.com with ESMTPSA id i4sm11544555pgg.67.2020.11.23.19.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 19:12:31 -0800 (PST)
Subject: Re: [PATCH v4] checkpatch: add fix and improve warning msg for
 Non-standard signature
To:     Joe Perches <joe@perches.com>
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <CAKXUXMx8siSm67jkBP_r+OKyKALfT2EDcX_SfX7JGBy3YisXcQ@mail.gmail.com>
 <20201123172430.12854-1-yashsri421@gmail.com>
 <148208ef84344069a6c95d3f686a86ca1199be90.camel@perches.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <6b3feb74-5f1d-ee1a-2e1a-8a5f803bed63@gmail.com>
Date:   Tue, 24 Nov 2020 08:42:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <148208ef84344069a6c95d3f686a86ca1199be90.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/20 11:03 pm, Joe Perches wrote:
> On Mon, 2020-11-23 at 22:54 +0530, Aditya Srivastava wrote:
>> Currently, checkpatch.pl warns for BAD_SIGN_OFF on non-standard signature
>> styles.
> 
> I think this proposed change is unnecessary.
>  
>> This warning occurs because of incorrect use of signature tags,
>> e.g. an evaluation on v4.13..v5.8 showed the use of following incorrect
>> signature tags, which may seem correct, but are not standard:
> 
> Standards are useful, but standards are not constraints.
> 
>> 1) Requested-by (count: 48) => Suggested-by
>> Rationale: In an open-source project, there are no 'requests', just
>> 'suggestions' to convince a maintainer to accept your patch
> 
> There's nothing really wrong with some non-standard signatures.
> And I think leaving humor like brown-paper-bag-by: is useful.
> 
> Just telling people that they are using a non-standard signature
> I think is enough.
> 

Hi Joe
Thanks for reviewing. We were also planning to provide fix for certain
non-standard signature warnings due to typo mistake in the signoffs,
using edit distance approach. These signatures were probably not
intended by the user.
E.g. for signatures like: 'Reviwed-by:', 'Singed-off-by:',etc.
Here is the list I have generated for non-standard signatures with
edit distance of 2 or less along with their count (over v4.13..v5.8).
(Among total 539 Non-standard signature warnings, warnings caused by
typo mistakes are 85 in number):

https://github.com/AdityaSrivast/kernel-tasks/blob/master/random/non_standard_signature/less_than2/signs_freq.txt

This is the predicted correct signoffs we are getting (for less than
or equal to 2):
https://github.com/AdityaSrivast/kernel-tasks/blob/master/random/non_standard_signature/less_than_3.txt


The reason I have chosen 2 as threshold is that count 3 onwards, the
results start deviating.
List for edit distance 3:
https://github.com/AdityaSrivast/kernel-tasks/blob/master/random/non_standard_signature/equal_3.txt

What do you think?

Thanks
Aditya
