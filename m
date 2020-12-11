Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8C62D78F4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437766AbgLKPQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437751AbgLKPQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:16:09 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6B2C0613D6;
        Fri, 11 Dec 2020 07:15:29 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id y24so8488304otk.3;
        Fri, 11 Dec 2020 07:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PmFoVM8cdLbSBeKjDeNu7C1NGjYnOTeXmcapFMRETFU=;
        b=ROjm2yH8V3TnerV2hvwxybdYK1Rtp6sX245vf4ySuRGwUnTo39PhcNkyjAJ1ie2r/t
         AQRtYHqOUNZ2UD7S3F5x9mlIOBTIGuwS/yaFb3pMqujoZsT4t6tWYQrPFdT9Q0zpT2NA
         YPDCm0B9gALed9FmSyZzJHmbmcM96Gjs+eo0ryc//OyxAfqXzjiEFrFVlDiAtXjCAXvK
         Rk/I8jYJessf1nK2FT0s4d9vs45WD/F0zpZSIw7rxC6b86kfz/wMWtyhhGa3vMLIA1Ul
         6K7L8r6NbLwjdzwSmUzQwkQCPV8IG/iMRzLCEz7C5TKC4SMJRFbCJclLJM4XuLcxmJP4
         cFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PmFoVM8cdLbSBeKjDeNu7C1NGjYnOTeXmcapFMRETFU=;
        b=UrngeeK4JDVpNZGDU4VDfxxfWl9pzh/sapDtuErhabeoRcMvqTmUHvpLONcfiChH+m
         cjlUMydzeVOWbM5K3Y+xAkZ5rSv1BsheTQ6/a0GRkTz1Kle0M95LkKfUsb+F7favIU4B
         wl9QgJ+YA0pJ4U8xW9VK55QEj87TdRDHHLV0s+pNy8tNwNDjRdcV95/4USe+brdHDvRI
         UOeH4CNLgPahI0Yt0kSozZVNkeadDC73judbmymqS/k0JXl085g4nObkgBMWYskvR2ip
         H0XiLPlf9E39QEBpp07d/+lLRYKgFHMoNOk3XBk3FsEOLac0K3UA9wKn0tQq3MPmSF+u
         9JeA==
X-Gm-Message-State: AOAM532TVkD/cZip+jGXEdNwleAiNu4OOiaf5skIFPnvzuzmP4EOSnjB
        IWEex5wW+4fNdfxdzB9B91mmnQhO9J4=
X-Google-Smtp-Source: ABdhPJw2C3hqf9IOeurFGo+oLjfVctMCcxnry8BBftT4/6Uvpjfu0pBXXcLZnLWIyMtJAd7A9Zf/nQ==
X-Received: by 2002:a9d:208a:: with SMTP id x10mr8471257ota.260.1607699728438;
        Fri, 11 Dec 2020 07:15:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a15sm1848684oii.50.2020.12.11.07.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 07:15:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v1] usb: typec: tcpm: Update vbus_vsafe0v on init
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201211071911.2205197-1-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <f6196a7e-0953-d458-a7d7-75e30446b407@roeck-us.net>
Date:   Fri, 11 Dec 2020 07:15:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211071911.2205197-1-badhri@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/20 11:19 PM, Badhri Jagan Sridharan wrote:
> During init, vbus_vsafe0v does not get updated till the first
> connect as a sink. This causes TCPM to be stuck in SRC_ATTACH_WAIT
> state while booting with a sink (For instance: a headset) connected.
> 
> [    1.429168] Start toggling
> [    1.439907] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> [    1.445242] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> [   53.358528] CC1: 0 -> 0, CC2: 0 -> 2 [state TOGGLING, polarity 0, connected]
> [   53.358564] state change TOGGLING -> SRC_ATTACH_WAIT [rev1 NONE_AMS]
> 
> Fix this by updating vbus_vsafe0v based on vbus_present status
> on boot.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index cedc6cf82d61..58a6302c549f 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4794,6 +4794,24 @@ static void tcpm_init(struct tcpm_port *port)
>  	if (port->vbus_present)
>  		port->vbus_never_low = true;
>  
> +	/*
> +	 * 1. When vbus_present is true, voltage on VBUS is already at VSAFE5V.
> +	 * So implicitly vbus_vsafe0v = false.
> +	 *
> +	 * 2. When vbus_present is false and TCPC does NOT support querying
> +	 * vsafe0v status, then, it's best to assume vbus is at VSAFE0V i.e.
> +	 * vbus_vsafe0v is true.
> +	 *
> +	 * 3. When vbus_present is false and TCPC does support querying vsafe0v,
> +	 * then, query tcpc for vsafe0v status.
> +	 */
> +	if (port->vbus_present)
> +		port->vbus_vsafe0v = false;
> +	else if (!port->tcpc->is_vbus_vsafe0v)
> +		port->vbus_vsafe0v = true;
> +	else
> +		port->vbus_vsafe0v = port->tcpc->is_vbus_vsafe0v(port->tcpc);
> +
>  	tcpm_set_state(port, tcpm_default_state(port), 0);
>  
>  	if (port->tcpc->get_cc(port->tcpc, &cc1, &cc2) == 0)
> 

