Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F88285CE2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 12:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgJGK2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 06:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbgJGK2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 06:28:45 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B97C061755;
        Wed,  7 Oct 2020 03:28:44 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a7so601064lfk.9;
        Wed, 07 Oct 2020 03:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H2N8UG6dic65TiBzlWgQu1CisgZIiaE0Rlzl4pcozag=;
        b=dQZAzOpLSe+lUXEaHN6i1aw7a5TaOeFrdXOH2fNI2pe6gMyFxHCoX25QpUjcmwtSff
         SqhLOXoXM5nmrEmv/gkd8R79Oe2MU4SnwRyzKBg9QN0pvUTMjMRFOzQda266SPjRJuCD
         rOku4rtjcbgptU43sta5UXoalx33PAsqNisO/dA2x05z3Rgfvpy3fUZrdqcMJy3zn3pP
         lvTbI5fSElsHhLyjBtR8uTLE1TNZmD2Fk5bC2EltQ7fSJDh6EP6mTqXtrvriABmsawGz
         EKCt+0sig1cn70EJ8vKfsAMK5Ic92jUFl8J1qJVqE6b0bMRlhKljp2aZ5zJ6cV4lEqAg
         IhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H2N8UG6dic65TiBzlWgQu1CisgZIiaE0Rlzl4pcozag=;
        b=SPV3QDtSo30h4KEiR7qkLQv3v04swWw4FToP/RwZ/mhnqbhHlzx5hMKWlZi8RJyklC
         Pd2cI87yEKq6DVT/MDpEg+nfTlLARzJS4CxETLOjUVgjylM2fEyf6ab/NOuNkK4tEyo5
         +DJ+SSIha/EJqsH8wWyC/cjEQTU6MUnIentrku5VRq79kNcqPpJNC/sRyJmAwnpXM6+O
         BNE5fYNzDIyoAmLQUrW489Bo480ZCaJEy4pz3qKTq3cQFbeVVFKUuYCZWwERY9/8XULl
         AeB/L+6tQsk89bXkOQUDeYeMibcWlOSTdONdLNyM9+Agmm1KiJaUH/c3itUyPwnF93Jj
         yd/Q==
X-Gm-Message-State: AOAM533HWSvuhbQoq5n5NciVXT9r/ROUeNS7p30GkHkNrB6ZF4AdxBP9
        N2YHjZpOquQem0HfYHOYsp4=
X-Google-Smtp-Source: ABdhPJzuS/fxGr0bBPYvubbiVZY9aJgTugLhxEnxd2+B2P4zw8n4WX1edPzG52Mqq3TE4dwGb5/H4A==
X-Received: by 2002:a19:4151:: with SMTP id o78mr694102lfa.408.1602066523199;
        Wed, 07 Oct 2020 03:28:43 -0700 (PDT)
Received: from wasted.omprussia.ru ([2a00:1fa0:826:1518:6ea7:4f6b:1e21:3742])
        by smtp.gmail.com with ESMTPSA id c20sm271406lfg.15.2020.10.07.03.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 03:28:42 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzJdIHVzYjogY2RuczM6IFZhcmlhYmxlIOKAmGxl?=
 =?UTF-8?Q?ngth=e2=80=99_set_but_not_used?=
To:     Roger Quadros <rogerq@ti.com>, Pawel Laszczak <pawell@cadence.com>,
        balbi@kernel.org
Cc:     peter.chen@nxp.com, nsekhar@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kurahul@cadence.com
References: <20201007033932.23050-1-pawell@cadence.com>
 <8994106d-2cc5-fa2c-bbcc-6526632ff80b@ti.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <18bf46b7-d86a-fbf0-9ce7-c2d0765758f1@gmail.com>
Date:   Wed, 7 Oct 2020 13:28:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8994106d-2cc5-fa2c-bbcc-6526632ff80b@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 10/7/20 11:15 AM, Roger Quadros wrote:

[...]
>> Patch removes not used variable 'length' from
>> cdns3_wa2_descmiss_copy_data function.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> 
> Fixes: commit 141e70fef4ee ("usb: cdns3: gadget: need to handle sg case for workaround 2 case")

   No "commit" is needed here.

> Acked-by: Roger Quadros <rogerq@ti.com>
[...]

MBR, Sergei
