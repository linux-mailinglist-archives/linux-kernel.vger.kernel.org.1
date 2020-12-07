Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB14A2D092F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 03:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgLGC3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 21:29:10 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:52237 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726489AbgLGC3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 21:29:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UHiWS7c_1607308106;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UHiWS7c_1607308106)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Dec 2020 10:28:26 +0800
Subject: Re: [PATCH] docs/zh_CN: Improve Cinese transolation quality.
To:     Ran Wang <gxndwr@outlook.com>, Harry Wei <harryxiyou@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <AT5PR8401MB09648490A868481BB51D7326CCF00@AT5PR8401MB0964.NAMPRD84.PROD.OUTLOOK.COM>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <718033fa-eb9f-63b7-5285-18fac2310721@linux.alibaba.com>
Date:   Mon, 7 Dec 2020 10:28:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <AT5PR8401MB09648490A868481BB51D7326CCF00@AT5PR8401MB0964.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/12/5 下午6:36, Ran Wang 写道:
> Signed-off-by: Ran Wang <gxndwr@outlook.com>
> ---
>  .../translations/zh_CN/process/1.Intro.rst    | 61 ++++++++++---------
>  1 file changed, 32 insertions(+), 29 deletions(-)
> 
> diff --git a/Documentation/translations/zh_CN/process/1.Intro.rst b/Documentation/translations/zh_CN/process/1.Intro.rst
> index 10a15f3dc282..73feae61410c 100644
> --- a/Documentation/translations/zh_CN/process/1.Intro.rst
> +++ b/Documentation/translations/zh_CN/process/1.Intro.rst
> @@ -11,33 +11,35 @@
>  执行摘要
>  --------
>  
> -本节的其余部分涵盖了内核开发过程的范围，以及开发人员及其雇主在这方面可能遇
> -到的各种挫折。内核代码应该合并到正式的（“主线”）内核中有很多原因，包括对用
> -户的自动可用性、多种形式的社区支持以及影响内核开发方向的能力。提供给Linux
> -内核的代码必须在与GPL兼容的许可证下可用。
> +本节的其余部分介绍了内核开发流程相关知识，其中包括开发者及其雇主在这方面可能遇
> +到的各种问题。内核代码合并到官方的（“主线”）仓库会有很多好处，比如能在第一时
> +间让用户获得更新，可以从社区得到多种形式的支持，以及能够以此影响内核未来发展方
> +向。需要注意提供给Linux内核的代码必须是在与GPL兼容的许可证下使用。

good. 
>  
> -:ref:`cn_development_process` 介绍了开发过程、内核发布周期和合并窗口的机制。
> -涵盖了补丁开发、审查和合并周期中的各个阶段。有一些关于工具和邮件列表的讨论。
> -鼓励希望开始内核开发的开发人员作为初始练习跟踪并修复bug。
> +:ref:`cn_development_process` 介绍了内核开发流程、发布周期以及合并窗口期相关的
> +机制。同时还讲解了补丁开发、审查和合并周期各个阶段要点。此外还包括一些关于工具
> +和邮件列表的讨论。我们建议那些希望开始内核开发的开发者们以跟踪并修复bug作为初
> +始练习。
>  

good.

>  
> -:ref:`cn_development_early_stage` 包括早期项目规划，重点是尽快让开发社区参与
> +:ref:`cn_development_early_stage` 介绍项目早期的工作规划，重点是尽快让开发社区
> +有机会参与到规划中
>  
> -:ref:`cn_development_coding` 是关于编码过程的；讨论了其他开发人员遇到的几个
> -陷阱。对补丁的一些要求已经涵盖，并且介绍了一些工具，这些工具有助于确保内核
> -补丁是正确的。
> +:ref:`cn_development_coding` 代码编写过程相关；

Maybe the original word is more fluency? 

> 讨论了一些其他开发者曾经走入到
> +的误区。并介绍社区对补丁的要求，同时指导如何通过使用一些工具来帮助确保内核补
> +丁的质量。

ok.

>  
> -:ref:`cn_development_posting` 讨论发布补丁以供评审的过程。为了让开发社区
> -认真对待，补丁必须正确格式化和描述，并且必须发送到正确的地方。遵循本节中的
> -建议有助于确保为您的工作提供最好的接纳。
> +:ref:`cn_development_posting` 介绍发布补丁以供评审的流程。补丁只有在符合特定的
> +格式及正确描述，并且发送到正确的地方，开发社区才有可能对其认真审查。遵循本节中
> +的建议有助于确保为您的工作成果提供最好的接纳。
>  
> -:ref:`cn_development_followthrough` 介绍了发布补丁之后发生的事情；该工作
> -在这一点上还远远没有完成。与审阅者一起工作是开发过程中的一个重要部分；本节
> -提供了一些关于如何在这个重要阶段避免问题的提示。当补丁被合并到主线中时，
> -开发人员要注意不要假定任务已经完成。
> +:ref:`cn_development_followthrough` 介绍了提交补丁之后发生的事情；至此工作实际

is it bybond 80 chars?

> +上还远未完成。与审阅者一起合作是开发过程中的重要部分；本节提供了一些关于如何在
> +这个重要阶段避免出现问题的提示。此外，即使当补丁已经被合并到主线中，开发者也不
> +能认为任务就此完成。
>  
>  :ref:`cn_development_advancedtopics` 介绍了两个“高级”主题：
> -使用Git管理补丁和查看其他人发布的补丁。
> +使用Git管理补丁和查看其他人提交的补丁。

Any different of above lines?
>  
>  :ref:`cn_development_conclusion` 总结了有关内核开发的更多信息，附带有带有
>  指向资源的链接.
> @@ -62,19 +64,20 @@ Linux最引人注目的特性之一是这些开发人员可以访问它；任何
>  内核开发周期可以涉及1000多个开发人员，他们为100多个不同的公司
>  （或者根本没有公司）工作。
>  
> -与内核开发社区合作并不是特别困难。但是，尽管如此，许多潜在的贡献者在尝试做
> -内核工作时遇到了困难。内核社区已经发展了自己独特的操作方式，使其能够在每天
> -都要更改数千行代码的环境中顺利运行（并生成高质量的产品）。因此，Linux内核开发
> +与内核开发社区合作并不是特别困难。但是，尽管如此，许多潜在的贡献者在尝试参与
> +内核开发时遇到了困难。内核社区已经发展了自己独特的开发流程，使其能够在每天
> +都要更改数千行代码的环境中顺利运转（并生成高质量的产品）。因此，Linux内核开发
>  过程与专有的开发方法有很大的不同也就不足为奇了。
good.

>  
> -对于新开发人员来说，内核的开发过程可能会让人感到奇怪和恐惧，但这个背后有充分的
> -理由和坚实的经验。一个不了解内核社区的方式的开发人员（或者更糟的是，他们试图
> -抛弃或规避内核社区的方式）会有一个令人沮丧的体验。开发社区, 在帮助那些试图学习
> -的人的同时，没有时间帮助那些不愿意倾听或不关心开发过程的人。
> +对于新开发者来说，内核的开发流程可能会让人感到陌生和望而生畏，但这个背后其实
> +是有充分的理由和坚实的实际经验作支撑。一个不了解内核社区工作方式的开发者（或
> +者更糟的是，如果他们试图抛弃或规避内核社区的方式）将会有一个令人沮丧的体验。
> +毕竟开发社区在帮助那些试图学习的人的同时，没有时间帮助那些不愿意倾听或不关心
> +开发流程的人。

good.

>  
> -希望阅读本文的人能够避免这种令人沮丧的经历。这里有很多材料，但阅读时所做的
> -努力会在短时间内得到回报。开发社区总是需要能让内核变更好的开发人员；下面的
> -文本应该帮助您或为您工作的人员加入我们的社区。
> +希望大家能通过阅读本文来避免那些令人沮丧的经历。这里有很多材料，请相信阅读这
> +些所付出的努力将会在短时间内得到回报。开发社区总是需要那些能让内核变更好的
> +开发者；下面的文章应当能帮助您或为您工作的人加入我们的社区。

good.
>  
>  致谢
>  ----
> 
