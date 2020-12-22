Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212AD2E0535
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 05:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgLVD71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 22:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgLVD70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:59:26 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED61C06179C;
        Mon, 21 Dec 2020 19:58:45 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id p126so13499307oif.7;
        Mon, 21 Dec 2020 19:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0s7Q78/+hwtoRDIuQ2huxjqR96uhxr8BwuYJzJt9anI=;
        b=Hv4gZTvl22vmijBneFIhasKknkzF5gmXpAS6JqwAHKEvpVIxrUsSBuLrfPhCwq1NUO
         fBaW250TE5UYRfc2g/jr8f6eR7VtrD+8sNS7rV8wcMVw4t8d9N7AE8XgEwArqjGgDrkS
         vOTg2cDoStge+/nfCzy9UYI0vaX+2FJi7llcmI/KWgoETc5hgeZYw8rmNS1dbmRT63gY
         k+6pGZtSBCd2qtszZLAPYsyGVI8tKjhT0vAH0QcpmBTJDHMUJIZPGEgu2sqjEfU5MA+j
         /WETmXV7mqk1nFhyWzlur5he+5fnMoTWTDcmWL0WAE51MiawjGgKLnZWC+V5D1Ol5OYI
         gRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0s7Q78/+hwtoRDIuQ2huxjqR96uhxr8BwuYJzJt9anI=;
        b=hGSFSnGcwDwWI0iDwrujtRjZzNn4EuCqUn6ydFQsCSLob7sI6X5Y/m4vYIk1NbZuT8
         mLWq6rXEXMtgQeQ77F69ANZYaoLp/Fv4pb3O1daZw53LHGl9SrpTsE1Bo6t4nbdpb/fU
         1ilOeMXcTihp2FuM6qKYQHlSIjH5xWMj7bgGjJdMA8hKXOp16T/uETwf1W05+TcSagj6
         hw7CIxsctXnq6dnA2inr2ilJqdisJK+VmC7VR15YAXlLNttMl1MSbYPmCbzwlIxakSWm
         wdetSjo0LbG1xaCHFdb3il7hWe3LxmsYs/N2xAcc0H5t6ZL7byuu9UOe3q1/Q5I20eXu
         HBxA==
X-Gm-Message-State: AOAM533kE2mtqvNKdZaf09M95onMscd9xd2vRFHVZ0rkKEHTxR+GffEA
        BDvKyiSF+HeHr8oqWdbJwtk=
X-Google-Smtp-Source: ABdhPJx1XFR6lnC9K0BlxkDgK5fGfK2j4HU+zSNxmQhqjNqZ0Ul5CtsJQpTO40cPT+IoX6WHOFW8iw==
X-Received: by 2002:aca:d603:: with SMTP id n3mr13229431oig.35.1608609525347;
        Mon, 21 Dec 2020 19:58:45 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x20sm4144414oov.33.2020.12.21.19.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 19:58:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: k10temp: ZEN3 readings are broken
To:     Gabriel C <nix.or.die@googlemail.com>
Cc:     linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Wei Huang <wei.huang2@amd.com>
References: <CAEJqkgiiU7miC13iT6DufjFAsHkNZk6rBAw=KRRnHe47kTZDnw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <9d621d34-e5ce-301a-1b89-92c0791fe348@roeck-us.net>
Date:   Mon, 21 Dec 2020 19:58:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEJqkgiiU7miC13iT6DufjFAsHkNZk6rBAw=KRRnHe47kTZDnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/21/20 5:45 PM, Gabriel C wrote:
> Hello Guenter,
> 
> while trying to add ZEN3 support for zenpower out of tree modules, I find out
> the in-kernel k10temp driver is broken with ZEN3 ( and partially ZEN2 even ).
> 
> commit 55163a1c00fcb526e2aa9f7f952fb38d3543da5e added:
> 
> case 0x0 ... 0x1:       /* Zen3 */
> 
> however, this is wrong, we look for a model which is 0x21 for ZEN3,
> these seem to
> be steppings?
> 
> Also, PLANE0/1 are wrong too, Icore has zero readouts even when fixing
> the model.
> 
> Looking at these ( there is something missing for 0x71 ZEN2 Ryzens
> also ) that should be:
> 
> PLANE0  (ZEN_SVI_BASE + 0x10)
> PLANE1  (ZEN_SVI_BASE + 0xc)
> 
> Which is the same as for ZEN2 >= 0x71. Since this is not really
> documented and I have some
> confirmations of these numbers from *somewhere* :-) I created a demo patch only.
> 
> I would like AMD people to really have a look at the driver and
> confirm the changes, since
> getting information from *somewhere*,  dosen't mean they are 100%
> correct. However, the driver
> is working with these changes.
> 
> In any way the model needs changing to 0x21 even if we let the other
> readings broken.
> 
> There is my demo patch:
> 
> https://crazy.dev.frugalware.org/fix-ZEN2-ZEN3-test1.patch
> 
> Also, there is some discuss and testing for both drivers:
> 
> https://github.com/ocerman/zenpower/issues/39
> 

Thanks for the information. However, since I do not have time to actively maintain
the driver, since each chip variant seems to use different addresses and scales,
and since the information about voltages and currents is unpublished by AMD,
I'll remove support for voltage/current readings from the upstream driver.
I plan to send the patch doing that to Linus shortly after the commit window
closes (or even before that).

Thanks,
Guenter
