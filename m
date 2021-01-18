Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448A92FABB1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 21:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394366AbhARUjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 15:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388344AbhARKgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:36:10 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75F3C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:35:28 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id u14so9122015wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=qHpDKbbt9PoxvMMJSyeYFi59FeeRW2QqtBOFQG4nRUk=;
        b=FcoB3gR2ELrvK/bDWk+9b2EVwT1WDXHWxfjZhk7qVT4jpoJhESvyN5hz8Fp9xgSqBE
         72NMvGtFMO6eylthlgM+xJtBuyXGsj/wyH7nkfFae/kVCek8sSbFUPdWv67G6KEdI1rD
         JdW5t+5I4dKgQHUCEjgkOWmKXCAxbO29UMdkpr2GCTkyVtZqezfZsoheXohyTs21Si+b
         scnQFvUWH7v0gO4OpK+y+GBcf4uvxjJ38EP6T1MZbkR8LzFlGFsV36ot35MLzg+Bt1gU
         ZnoKWNLX9VMiMvnaP6VUO37K/SgkN8qj32AYkMCIPPY+2kPYvU5bUZUNAw1w7GIzlGz1
         DY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qHpDKbbt9PoxvMMJSyeYFi59FeeRW2QqtBOFQG4nRUk=;
        b=mHKHrO5MxcP/ogujKiVJ1XbcYEsck4POn3bMSFOfiERuLOKszNz5Gh6CIxWweQLJRH
         cnTv51zTnSC6x0Zz0hDE/qd1dfgcu/9hovJ52y6jC0HfNcgjtGxShq6vTN87vyeTzlcp
         9sNaYj1AC+/empE2m9hbN79lD/mrUfHztempY3jETaovWNqzgKZ426Skp0KYX5uB+0jm
         TG2qrNTjfgFFZdXKQv+JFHEMJKNNRcoCEGH4EgY08dOQyjL3GBRHjyhtKA1e/OUvJOZq
         eQip1YYnwsd3865wkumvkPRJAnTfcEF0gghh5XfZIqUvZwC4xRcTybuaX+Fpu6IVuDdl
         YHKg==
X-Gm-Message-State: AOAM531pzC9bCpQTqJiHf4D4Ul7fNsuxbDlDNv/A7SXLvezMZKHWwWov
        b6/tCfcT/xRrm23jjRzO0WA=
X-Google-Smtp-Source: ABdhPJyYvvw3xaQNo+D3suMyynXxgvVKqK0uHDFVWfhr8+6J2pJ33erDo63LzXfW8gJiIgsMbnE2Dg==
X-Received: by 2002:a05:600c:214d:: with SMTP id v13mr9526674wml.186.1610966127598;
        Mon, 18 Jan 2021 02:35:27 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id a12sm32386007wrh.71.2021.01.18.02.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 02:35:27 -0800 (PST)
Subject: Re: [PATCH v2] software_node: Add kernel-doc comments to exported
 symbols
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com
References: <20210113000209.322218-1-djrscally@gmail.com>
 <20210118094945.GX11878@paasikivi.fi.intel.com>
 <20210118103355.GZ4077@smile.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <0c433f0a-3ae5-1956-988c-9f4dfdb79fbc@gmail.com>
Date:   Mon, 18 Jan 2021 10:35:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210118103355.GZ4077@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2021 10:33, Andy Shevchenko wrote:
> On Mon, Jan 18, 2021 at 11:49:46AM +0200, Sakari Ailus wrote:
>> On Wed, Jan 13, 2021 at 12:02:09AM +0000, Daniel Scally wrote:
>>> + * to_software_node() - Fetch software node associated with a firmware node handle
>> Please wrap lines over 80 (unless there's a reason to keep them longer).
> Does kernel-doc behave good when you wrap the function summary line?
> My impression that summary should be one line.
>
Same, but I can shorten the line by s/associated with/linked to or
something along those lines
