Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8FE28F72B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 18:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389911AbgJOQwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 12:52:40 -0400
Received: from foss.arm.com ([217.140.110.172]:49004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730137AbgJOQwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 12:52:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFB08D6E;
        Thu, 15 Oct 2020 09:52:38 -0700 (PDT)
Received: from [10.57.48.76] (unknown [10.57.48.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8F013F71F;
        Thu, 15 Oct 2020 09:52:36 -0700 (PDT)
Subject: Re: [PATCH 1/7] of: base: Add of_count_phandle_with_fixed_args()
To:     Rob Herring <robh+dt@kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     devicetree@vger.kernel.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        - <patches@opensource.cirrus.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
References: <20201014145418.31838-1-rf@opensource.cirrus.com>
 <20201014145418.31838-2-rf@opensource.cirrus.com>
 <CAL_Jsq+qdcHc9H7qUVwLieHrLM8E20HZXa8DkarMiuXfCh8WOQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <90600a67-25e4-7933-35c3-f515deaee94f@arm.com>
Date:   Thu, 15 Oct 2020 17:52:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+qdcHc9H7qUVwLieHrLM8E20HZXa8DkarMiuXfCh8WOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-14 19:39, Rob Herring wrote:
> On Wed, Oct 14, 2020 at 9:54 AM Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
>>
>> Add an equivalent of of_count_phandle_with_args() for fixed argument
>> sets, to pair with of_parse_phandle_with_fixed_args().
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
>>   drivers/of/base.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/of.h |  9 +++++++++
>>   2 files changed, 51 insertions(+)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index ea44fea99813..45d8b0e65345 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -1772,6 +1772,48 @@ int of_count_phandle_with_args(const struct device_node *np, const char *list_na
>>   }
>>   EXPORT_SYMBOL(of_count_phandle_with_args);
>>
>> +/**
>> + * of_count_phandle_with_fixed_args() - Find the number of phandles references in a property
>> + * @np:                pointer to a device tree node containing a list
>> + * @list_name: property name that contains a list
>> + * @cell_count: number of argument cells following the phandle
>> + *
>> + * Returns the number of phandle + argument tuples within a property. It
>> + * is a typical pattern to encode a list of phandle and variable
>> + * arguments into a single property.
>> + */
>> +int of_count_phandle_with_fixed_args(const struct device_node *np,
>> +                                    const char *list_name,
>> +                                    int cells_count)
>> +{
> 
> Looks to me like you can refactor of_count_phandle_with_args to handle
> both case and then make this and of_count_phandle_with_args simple
> wrapper functions.

Although for just counting the number of phandles each with n arguments 
that a property contains, isn't that simply a case of dividing the 
property length by n + 1? The phandles themselves will be validated by 
any subsequent of_parse_phandle*() call anyway, so there doesn't seem 
much point in doing more work then necessary here.

>> +       struct of_phandle_iterator it;
>> +       int rc, cur_index = 0;
>> +
>> +       if (!cells_count) {
>> +               const __be32 *list;
>> +               int size;
>> +
>> +               list = of_get_property(np, list_name, &size);
>> +               if (!list)
>> +                       return -ENOENT;
>> +
>> +               return size / sizeof(*list);

Case in point - if it's OK to do exactly that for n == 0, then clearly 
we're *aren't* fussed about validating anything, so the n > 0 code below 
is nothing more than a massively expensive way to check for a nonzero 
remainder :/

Robin.

>> +       }
>> +
>> +       rc = of_phandle_iterator_init(&it, np, list_name, NULL, cells_count);
>> +       if (rc)
>> +               return rc;
>> +
>> +       while ((rc = of_phandle_iterator_next(&it)) == 0)
>> +               cur_index += 1;
>> +
>> +       if (rc != -ENOENT)
>> +               return rc;
>> +
>> +       return cur_index;
>> +}
>> +EXPORT_SYMBOL(of_count_phandle_with_fixed_args);
>> +
>>   /**
>>    * __of_add_property - Add a property to a node without lock operations
>>    */
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index 5cf7ae0465d1..9f315da4e9da 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -377,6 +377,8 @@ extern int of_parse_phandle_with_fixed_args(const struct device_node *np,
>>          struct of_phandle_args *out_args);
>>   extern int of_count_phandle_with_args(const struct device_node *np,
>>          const char *list_name, const char *cells_name);
>> +extern int of_count_phandle_with_fixed_args(const struct device_node *np,
>> +       const char *list_name, int cells_count);
>>
>>   /* phandle iterator functions */
>>   extern int of_phandle_iterator_init(struct of_phandle_iterator *it,
>> @@ -886,6 +888,13 @@ static inline int of_count_phandle_with_args(struct device_node *np,
>>          return -ENOSYS;
>>   }
>>
>> +static inline int of_count_phandle_with_fixed_args(const struct device_node *np,
>> +                                                  const char *list_name,
>> +                                                  int cells_count)
>> +{
>> +       return -ENOSYS;
>> +}
>> +
>>   static inline int of_phandle_iterator_init(struct of_phandle_iterator *it,
>>                                             const struct device_node *np,
>>                                             const char *list_name,
>> --
>> 2.20.1
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
