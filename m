Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF12288520
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 10:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732744AbgJIIW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 04:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgJIIWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 04:22:55 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765B1C0613D2;
        Fri,  9 Oct 2020 01:22:55 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y16so7602435ljk.1;
        Fri, 09 Oct 2020 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z4PYgixxEo74naXVTGCu473YIzjZyoMssDBGjCVNhz8=;
        b=DvEcPpSsHXvt+QCKNgFD0OGbS0cOIPIHELaLxGjbP37VbXYPPozfcIRAdrSmOR8HvV
         S0tXg49NuxysApDt+TalMm467uLyRoSZH2lrDZZLGXmK8gSf7V+wzyQgEb6o61PcH5Eu
         /SuIDyKLxzATkYuFFkoZlx6a4PFXw02IiWr6VZs+tCcpjLnbSgJe1xMkU7OsWzpp2T83
         6oc/b4AfsTwrDsWLkm4NURIQhxqyyTGdolrTaI2z401NHkwA98DrBFAPgRZL6kXk6lIi
         fTcClX+nTlqX7peXiWnk3fFFg5pFFegtt5+0QvuQbsaFt8F9gJcm5/zw03TVhozozCz1
         ecHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=z4PYgixxEo74naXVTGCu473YIzjZyoMssDBGjCVNhz8=;
        b=EZP3mKv6UWLm2Fzb8sDRCOBHfqyZuK/JNitwyNLdU9KWPegQi+ebRwVJQM3E+qQHwJ
         y0W/rk26qUpOLsgejP2c8A7nCwGDpuMfVRDsql+SxUlg+fyxFRexJViFORPFrgsMnQ3m
         8uLd6awEHOhJE0Q8Eet/Ag619jZAAABC5iqnh/HQ6zX44cz9ESI2JrAqS2NDo7DUTof4
         OnK8eXJFK+ZfpODTU0OIGuKXErTQQFhvaD9ZkEGx0uW4V8lMAXwaLxrDnfs9EzvbtEyr
         1WJnbYwfKAqIGB3KnRlUQgoe3lxoDMslW3N86fmcgrDJFuYa1IvAfMp3+wtg+UlbZ3l2
         r0Ww==
X-Gm-Message-State: AOAM532UpHeaDg7xyTOWiga+bPxoXqvpvfcdeL5JuQRbeigfkwjjiBaa
        C+eClQM3ZjZsYeWvrUMH4lQVuBAd/P7Vwg==
X-Google-Smtp-Source: ABdhPJyCc0AibnzQbXHWDVK6b5qd4dQXk2CIZ+rxQ8FfNIh/3E1HoS8vWe1fFdjiMjJKICo8WL7eRw==
X-Received: by 2002:a2e:8159:: with SMTP id t25mr4863515ljg.137.1602231773820;
        Fri, 09 Oct 2020 01:22:53 -0700 (PDT)
Received: from [192.168.1.100] ([213.87.137.199])
        by smtp.gmail.com with ESMTPSA id v11sm682269ljk.109.2020.10.09.01.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 01:22:53 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] ARM: dts: add ehci uhci enable in evb dts
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, bmc-sw@aspeedtech.com,
        Alan Stern <stern@rowland.harvard.edu>
References: <20200930040823.26065-4-ryan_chen@aspeedtech.com>
 <20201009024937.11246-1-ryan_chen@aspeedtech.com>
 <20201009024937.11246-4-ryan_chen@aspeedtech.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <4efff4e7-27e0-35be-c112-5377f222a478@gmail.com>
Date:   Fri, 9 Oct 2020 11:22:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201009024937.11246-4-ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HEllo!

On 09.10.2020 5:49, Ryan Chen wrote:

> Add EHCI UHCI enable build in aspeed-ast2600-evb.dts

    Enable ECHI/UHCI for the  Aspeed AST2600 EVB, perhaps?

> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
[...]

MBR, Sergei
