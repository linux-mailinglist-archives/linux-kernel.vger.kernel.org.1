Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC5826F8AF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgIRIvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:51:54 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:46803 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIRIvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:51:53 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mdvua-1kryhy0arW-00b2Y4 for <linux-kernel@vger.kernel.org>; Fri, 18 Sep
 2020 10:51:52 +0200
Received: by mail-qk1-f173.google.com with SMTP id w16so5297922qkj.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 01:51:51 -0700 (PDT)
X-Gm-Message-State: AOAM531H/1Yo2Qf1i09Qh0WpSVV6jxuhy4e0tKJJKJ7LfIOhEI5xV9O1
        4fGtppTsHANq0sFjDVdplyqyJNvChG0pY5EEldQ=
X-Google-Smtp-Source: ABdhPJyAbREyEKw/r2Uzf8f38YUY9SiISyYWk1+dnfzS/R5dWNaiSZgiPnmBO0fkWF3oysCOOW5iLi/1818oL1N3w0M=
X-Received: by 2002:a37:5d8:: with SMTP id 207mr32954395qkf.352.1600419111033;
 Fri, 18 Sep 2020 01:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200918083634.33124-1-bobo.shaobowang@huawei.com>
In-Reply-To: <20200918083634.33124-1-bobo.shaobowang@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Sep 2020 10:51:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0w2Ezcwm0jeRN6LFXZCSHgYB-qRkFfXcK16gWQOOcqVA@mail.gmail.com>
Message-ID: <CAK8P3a0w2Ezcwm0jeRN6LFXZCSHgYB-qRkFfXcK16gWQOOcqVA@mail.gmail.com>
Subject: Re: [PATCH -next] misc: pvpanic: Use devm_platform_ioremap_resource()
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     cj.chengjian@huawei.com, Libin <huawei.libin@huawei.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Ia/D76xhc4RFuTGM1F82+akJiPE/7ALbR+XGCvuFqx/Hhr1/AoA
 kSL6FkKRikR3Q26bCyhCnABJaFAg0u9IZUYY6TJFXd12IjjAEi3W7HxhgQ1+Rzck6rNG/Fm
 Oap4yvgJtqlRZnb2BQCqJkidFPqp/cRIzY1v4FDvsEZ4ft2+WTJqJXdlz6BudgT1QGukl3A
 5VskHp7D5PCqJnI/pcD9g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EtBO/uDhLDk=:mL3iOAIItDR0e9SXjPK0sa
 cWQdTpfIg57JTCaMBIE4+CeiW58CO8LwLiMUWEHbgIptmly1HP6RXuA6RKK4hfWjYAQctOa9t
 S9Sk7ojqya/LqYOxXJf0qOLB+HL84vJhXUgUivjl1q6xCsNQcDYSZYb9raEBR/tCHXZx/dgB8
 8Oer5H8pmaeATUHGvMfKmCyX1gtQvPbsDksMRvzSVbvhiDLQTZAYqoyalBGlgo1Uc1CtAItIZ
 owCvF9TT6SKSzg6SZFHvqPn8BSl6nn9XjxTZdbMQ2g9CsnN0xkdanhL3roshI0giOgi0f98Zk
 hPbvWOMzF16ahnaCWjEreZzTcxI3DTQUmAuqqauL9+yErXgYmXamuqpgQ4qI8YNYrWiA0Nhwq
 oNjx2aT3zIGDRYwd439r3SlkYEILJuBY3gHcNLMDtWUvFFT+YC+DKHBvEkHv0xjoFO3O3cfZT
 AJIkzwnYXpm1QoVvAzKVgQT4F61RmOk87Io6F5AUkL1rk2LEpd1nwZ9kSkJqWH92vBmWJSzl0
 PiU/2g/KhPIpYGPG3s35J4oOfX8GZ7XsOe4pNR/y114i8imkdYd7vlY+gIRXC0h3JR2Zt8T5j
 uWq/0a/im7t4ofTfoA0LgyCSYQdr3aU/CkJEaFqu1EjRm3rpjCxJyrwCt4eGE9NIGlwSEArfz
 i5JqcwW3vKBqgc61p4myZChfPY2OWPhwT7zsIopYQRLiZOu/7s5gtv+aJjpoczgsEiQ9K2UXy
 ODdRXihxAVelNf+j0oTY/QanqNLJFV2Uv7tJRDiexk+riVIBDM0gRIOOJa9VrU9aQIgGOQl93
 VEwuBj4u/LwmRoyI/wdHwzRQna0zAnY1A41rKlXHTLrKG9EiH2PSODUzn5c+7yAdzAtXAastG
 9j3FeJndPuu0ClnHIGGs01BrJsFQL0Ob1hQe+Hus/B9QyIlRPpzRdCNa4avzKZRZ3Ir3LvBRG
 2h3O/V+EKPDRQ8N/t+fFANNznvhg7q62CBJbMIPnIpQDI+HBQ9gSG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 10:37 AM Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:
>
> Make use of devm_platform_ioremap_resource() provided by driver
> core platform instead of duplicated analogue.
>
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>

Acked-by: Arnd Bergmann <arn@arndb.de>
