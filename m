Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F145240B06
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 18:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgHJQNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 12:13:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24900 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727014AbgHJQNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597075991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H9NbL7BuOVY7OV2uG0JjWXUOXiSDqCAAra8i3Kyx9ys=;
        b=SW2mucNbpEQz86Sfu1EoNGcVhkWN3YqJF+OoML3NMtrKWTCH1usam12MPHgewOD6aBzVEQ
        mad1Vx2/jqaENtPBs5UqPalOk+q12lgpIYcgqRwOMxI39sg+s2N+XQsfMTJsGS3OLBqGYs
        6Z31mkrseoDovQ5DmYFOmEfr4yOJDV0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-0aVkbPlZO2GsVG7aTCx_QA-1; Mon, 10 Aug 2020 12:13:09 -0400
X-MC-Unique: 0aVkbPlZO2GsVG7aTCx_QA-1
Received: by mail-ed1-f70.google.com with SMTP id c16so3447639edt.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 09:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H9NbL7BuOVY7OV2uG0JjWXUOXiSDqCAAra8i3Kyx9ys=;
        b=qF2T4VVSt8hRh0cpaSG5BTyPIFHLcpxj0DJ0DkfmKH5zpxjgjUfKmbpBi7dD2LuNEA
         S7VooRh8WFlORgA5LWNWkD8bVIskFNdRgjiMBjXC4fA0qqVuenEEpyVi3QMsY+5b1aYD
         d1re00143XZwiZLh4cJajnjvCYBrppfuYdCcmyEnAQKMRdwyb93RRqokUdexLgcTP3jd
         tfqv867GNsbEdkyI37lmIg9hgqF6vbCVUYtelbJpnzKg/mBCo0lRO8p9EDQn5E9IpX6l
         /YeilOZqjqBYrWjWI6THU03npdGbkW3aYz6ce2y21kmfPkK/Hm+PPKonb2k0jG1CrndH
         IdFA==
X-Gm-Message-State: AOAM532s5vHqEKkyLOpCpSBRfFhHKOgnb2MVLvWlRSn50p3xcT+d9J5Q
        xWee/tuu1LCLD4KhcivKiG82IEz8Qi/ZNOftXmxDinBMbgMZSeJ8UxmGiRaMEWj9bdcUw2AgkgB
        14VyWHiQz3kzl5pNryFb+eFxb
X-Received: by 2002:a17:906:4e4f:: with SMTP id g15mr7668515ejw.443.1597075988270;
        Mon, 10 Aug 2020 09:13:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw634rxLv7uP3URuVlm7vJgMhPNE4cdFwiw2cBnrRPTlgtvrBBFPpyRdyAxr3RSb4I585qyYw==
X-Received: by 2002:a17:906:4e4f:: with SMTP id g15mr7668474ejw.443.1597075987952;
        Mon, 10 Aug 2020 09:13:07 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id i26sm12462532edv.70.2020.08.10.09.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 09:13:07 -0700 (PDT)
Subject: Re: [PATCH] HID: i2c-hid: Add 60ms delay after SET_POWER ON
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     Pavel Balan <admin@kryma.net>,
        Daniel Playfair Cal <daniel.playfair.cal@gmail.com>,
        HungNien Chen <hn.chen@weidahitech.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        Aaron Ma <aaron.ma@canonical.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200810142928.12552-1-kai.heng.feng@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <bbe5fde3-e0df-053e-a30a-a55c780b1f69@redhat.com>
Date:   Mon, 10 Aug 2020 18:13:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200810142928.12552-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10-08-2020 16:29, Kai-Heng Feng wrote:
> Goodix touchpad fails to operate in I2C mode after system suspend.
> 
> According to the vendor, Windows is more forgiving and there's a 60ms
> delay after SET_POWER ON command.
> 
> So let's do the same here, to workaround for the touchpads that depend
> on the delay.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Interesting I send a very similar patch a couple of days ago,
after debugging some touchpads issues on a BMAX Y13 laptop:

https://patchwork.kernel.org/patch/11701541/

If you look at that patch you will see that if we add a
sleep on power-on to i2c_hid_set_power(), we can remove
an existing sleep after power-on from i2c_hid_hwreset().

And there is an interesting comment there which should
probably be moved (as my patch does) and corrected for the
new knowledge so that people reading the code in the future
now why the sleep is there.

Other then that we've come to the same conclusion, but
your sleep is much longer. I guess that is ok though,
are you sure we need 60ms as a minimum? Is that what goodix
said?

Regards,

Hans


> ---
>   drivers/hid/i2c-hid/i2c-hid-core.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 294c84e136d7..7b24a27fad95 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -419,6 +419,9 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
>   	if (ret)
>   		dev_err(&client->dev, "failed to change power setting.\n");
>   
> +	if (!ret && power_state == I2C_HID_PWR_ON)
> +		msleep(60);
> +
>   set_pwr_exit:
>   	return ret;
>   }
> 

