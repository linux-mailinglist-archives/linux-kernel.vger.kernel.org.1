Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6BD2E239B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 03:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgLXCTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 21:19:01 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:44124 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727802AbgLXCTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 21:19:01 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UJb3vJ._1608776296;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UJb3vJ._1608776296)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Dec 2020 10:18:17 +0800
Subject: =?UTF-8?B?UmU6IGxpbnV4IGtlcm5lbOaWsOaJi+aDs+WPguS4juaWh+aho+e/uw==?=
 =?UTF-8?B?6K+R?=
To:     =?UTF-8?B?6ams5Y6f6YeO?= <yuanye.ma@qq.com>,
        linux-doc@vger.kernel.org
References: <tencent_8666121ADC28A5099719E06674964F7A3208@qq.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <79aba0de-a6ed-f686-fe2a-81cde23cdc0f@linux.alibaba.com>
Date:   Thu, 24 Dec 2020 10:18:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <tencent_8666121ADC28A5099719E06674964F7A3208@qq.com>
Content-Type: text/plain; charset=gb18030
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC linux-doc

在 2020/12/23 下午11:03, 马原野 写道:
> 前辈您好：
>       我是一名Linux开发工程师，同时也是一个开源爱好者，我在kernel的Documentation/translations/zh_CN中看到您的联系方式。我对您翻译内核文档的工作很感兴趣，觉得是一件非常有意义的事情，因此我也想贡献一点自己的力量。

欢迎欢迎，非常欢迎， 很高兴看到越来越多的内核中文文档， 相信这会促进和鼓励中国的内核开发工作！

>       非常冒昧的给您发这封邮件，目的是想咨询您我该如何参与到内核文档的翻译工作中，比如翻译工作的流程、怎么提交或者推送我翻译的文档、翻译文档的格式要求等等。
>       请问翻译内核文档的工作是否也是像向内核中提交代码那样工作？在Documentation/translations/zh_CN目录中按照Documentation/的目录结构创建自己要翻译的文档，翻译完成后向中文版的维护者推送合并请求，或者向维护者的邮箱发送patch文件？请问翻译文档有没有类似于CodingStyle的格式要求？

翻译文档没有专用的coding style, 它也类似于普通内核开发， 需要符合普通的 coding style, 但是在行长度的计算上中文字符一个等于英文2个，其他方面也需要符合内核代码开发的要求， 比如需要通过 make help 中的，make cleandocs/htmldocs 等。 需要发送前在浏览器上实际检查 htmldocs 等文档的效果,确保各个链接有效等。它也需要提交patch 给Jonathan Corbet <corbet@lwn.net>, cc 给相关人员。

>       非常感谢您百忙之中抽出时间查看这封邮件，冒昧打扰，实属抱歉，非常希望前辈能解答我的困惑，如果能再给我一些参与内核开发的建议，我将不胜感激，非常期待您的回信。

内核社区很多人乐意在 patch review 时给新人很多建议。 加油！

>      
>       祝：身体健康，工作顺利。

谢谢， 祝，翻译快乐！

奎亮
Alex 
