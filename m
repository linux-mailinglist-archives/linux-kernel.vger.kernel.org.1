Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CF82C7A07
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgK2QjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2QjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:39:14 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28617C0613CF;
        Sun, 29 Nov 2020 08:38:34 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 131so8746558pfb.9;
        Sun, 29 Nov 2020 08:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zHdDK+dmWn8gCx5N2jMxoQKX0RRPwzh45mj3hu0wPTI=;
        b=k8LJ3ofxbaEDXqtJqsn+MQmQ1WyUzQ8KBZqjnmOy4m8kugY0plvzl1PFPOHA8gtjdc
         Mo4EscHW48LGZHZhZSkKo4w3A2rCL5lf7/ZJgGrr/WcenDfctf+sguY1z+Xa0AJAT/HD
         CLtJfy8tG/b6sgbs3eYDxb/djbojTSoPG8gWGYYBcdfpSAsffG78LMIjKInE3lUtW1jJ
         GyChVnDgh+Jwfc2KVa19u9spWVo9yldmaynpbcCXPSIP9OZTgpdFhqDBNYbDzGTydOEE
         hlnxXhd4m38KFkClAgQMxIyf/ax52MZbIBkVTpXSF4GeRBB+EJZzuqTpFlraNaMpD/Q6
         vGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zHdDK+dmWn8gCx5N2jMxoQKX0RRPwzh45mj3hu0wPTI=;
        b=nUdrhAcxJXJxfMcoGwFvMEpbJu559rITKj+dXajjwveLCaysx7yNxUtnMrNuGxVPJY
         hkjUw1leIfUjtPnAD4fj2FyFS+fOo9qV5PQ3jrpPtWpS74miKYGcimGoCLyC0f3PTRcc
         Mi5n++uhzSYHnc1IRPQX5VxihK5A1fiyjYyDWJDc/ze9gq12XFY35eOzuxgNQkJIQ3nA
         0LWJeO86UAo3fOBSlIhPV10OVbFkAK0E6ieILxjE5R4H4hUqFc6gin0vhidO+KPhCX8a
         Tih45uWrhPjW/JxKCNyGP2IHRqONhaTg+ig9172rpAI3R7/pRbM3CraPVcYD0z9dRcFh
         HyGA==
X-Gm-Message-State: AOAM531zJW3KfEiBjnyt1VDw5WHKuR8/pUkbykBefAWBrmG0e3CCVgod
        mm5UwC816TtQb1AzbACeKq8vGug922kF3fLuW5E=
X-Google-Smtp-Source: ABdhPJyxIprkMw3TNMRFj6zBOvRavLjgksCcdNrTLnwuq9D3qq7Lzl6dAYIAxzhOt4a+LXZFJ3NMvg==
X-Received: by 2002:a17:90a:f288:: with SMTP id fs8mr18371210pjb.184.1606667912972;
        Sun, 29 Nov 2020 08:38:32 -0800 (PST)
Received: from [192.168.0.104] ([49.207.196.188])
        by smtp.gmail.com with ESMTPSA id e8sm13876144pfj.157.2020.11.29.08.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Nov 2020 08:38:32 -0800 (PST)
Subject: Re: [PATCH 03/15] usb: misc: cytherm: update to use
 usb_control_msg_recv()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201129160612.1908074-1-anant.thazhemadam@gmail.com>
 <20201129160612.1908074-4-anant.thazhemadam@gmail.com>
 <X8PJQzUZymkClmbE@kroah.com>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <eee3cc73-d346-8f04-b4ff-72561703bd05@gmail.com>
Date:   Sun, 29 Nov 2020 22:08:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X8PJQzUZymkClmbE@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/11/20 9:46 pm, Greg Kroah-Hartman wrote:
> There's no more need to dynamically allocate the buffer variable here
> now, right?  It can be on the stack as the change you made above allows
> that to work properly, no need to allocate the buffer twice in a row
> (once here and once in the USB core).
>
> That would make these functions less complex, always a good thing.
>
> You should check this on the other patches in this series as well.

Understood, I will do that. I apologize for the oversight.

Thanks,
Anant
